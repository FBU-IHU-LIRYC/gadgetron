#include "cuSenseBuffer.h"
#include "vector_td_utilities.h"
#include "cuNDArray_utils.h"

namespace Gadgetron{

  template<class REAL, unsigned int D, bool ATOMICS>
  cuSenseBuffer<REAL,D,ATOMICS>::cuSenseBuffer() 
  {
    num_coils_ = 0;
    cur_idx_ = cur_sub_idx_ = 0;
    cycle_length_ = 0; sub_cycle_length_ = 0;
    acc_buffer_empty_ = true;
    Gadgetron::clear(matrix_size_);
    Gadgetron::clear(matrix_size_os_);
    W_ = REAL(0);
  }
  
  template<class REAL, unsigned int D, bool ATOMICS>
  void cuSenseBuffer<REAL,D,ATOMICS>::clear()
  {
    Gadgetron::clear(&acc_buffer_);
    Gadgetron::clear(&cyc_buffer_);

    cur_idx_ = cur_sub_idx_ = 0;
    acc_buffer_empty_ = true;
  }

  template<class REAL, unsigned int D, bool ATOMICS>
  void cuSenseBuffer<REAL,D,ATOMICS>::
  setup( _uintd matrix_size, _uintd matrix_size_os, REAL W, 
	 unsigned int num_coils, unsigned int num_cycles, unsigned int num_sub_cycles )
  {      
    bool matrix_size_changed = (matrix_size_ == matrix_size);
    bool matrix_size_os_changed = (matrix_size_os_ == matrix_size_os);
    bool kernel_changed = (W_ == W);
    bool num_coils_changed = (num_coils_ == num_coils );
    bool num_cycles_changed = (cycle_length_ == num_cycles+1);
    bool is_virgin = (E_.get() == 0x0);
    //bool num_sub_cycles_changed = (sub_cycle_length_ == num_sub_cycles);

    matrix_size_ = matrix_size;
    matrix_size_os_ = matrix_size_os;
    W_ = W;
    num_coils_ = num_coils;
    cycle_length_ = num_cycles+1; // +1 as we need a "working buffer" in a addition to 'cycle_length' full ones
    sub_cycle_length_ = num_sub_cycles;

    std::vector<unsigned int> dims = to_std_vector(matrix_size_);
    
    if( is_virgin )
      E_ = boost::shared_ptr< cuNonCartesianSenseOperator<REAL,D,ATOMICS> >(new cuNonCartesianSenseOperator<REAL,D,ATOMICS>);
    
    if( is_virgin || matrix_size_changed || matrix_size_os_changed || kernel_changed ){
      E_->set_domain_dimensions(&dims);
      E_->setup( matrix_size_, matrix_size_os_, W );
      nfft_plan_.setup( matrix_size_, matrix_size_os_, W );
    }
    
    dims = to_std_vector(matrix_size_os_);    
    dims.push_back(num_coils_);

    if( acc_buffer_.get_number_of_elements() == 0 || matrix_size_os_changed || num_coils_changed ){
      acc_buffer_.create(&dims);
      Gadgetron::clear( &acc_buffer_ );
    }

    dims.push_back(cycle_length_);
    if( cyc_buffer_.get_number_of_elements() == 0 || matrix_size_os_changed || num_coils_changed ){
      cyc_buffer_.create(&dims);      
      Gadgetron::clear( &cyc_buffer_);
    }
    else if( num_cycles_changed ){
      // Reuse the old buffer content in this case...
      // This happens automatically (in all cases?) with the current design?
    }
  }
  
  template<class REAL, unsigned int D, bool ATOMICS> 
  bool cuSenseBuffer<REAL,D,ATOMICS>::add_frame_data( cuNDArray<_complext> *samples, cuNDArray<_reald> *trajectory )
  {
    if( !samples || !trajectory ){
      throw std::runtime_error("cuSenseBuffer::add_frame_data: illegal input pointer");
    }

    if( num_coils_ != samples->get_size(samples->get_number_of_dimensions()-1) ){
      throw std::runtime_error("cuSenseBuffer::add_frame_data: unexpected number of coils according to setup");
    }

    if( dcw_.get() == 0x0 ){
      throw std::runtime_error("cuSenseBuffer::density compensation weights not set");
    }
    
    // Make array containing the "current" buffer from the cyclic buffer
    //

    cuNDArray<_complext> cur_buffer(acc_buffer_.get_dimensions().get(),
				    cyc_buffer_.get_data_ptr()+cur_idx_*acc_buffer_.get_number_of_elements());

    // Preprocess frame
    //

    nfft_plan_.preprocess( trajectory, cuNFFT_plan<REAL,D,ATOMICS>::NFFT_PREP_NC2C );
    
    // Convolve to form k-space frame (accumulation mode)
    //
    
    nfft_plan_.convolve( samples, &cur_buffer, dcw_.get(), cuNFFT_plan<REAL,D,ATOMICS>::NFFT_CONV_NC2C, true );

    // Update the accumulation buffer (if it is time...)
    //

    bool cycle_completed = false;

    if( cur_sub_idx_ == sub_cycle_length_-1 ){

      cycle_completed = true;
      
      // Buffer complete, add to accumulation buffer
      //

      acc_buffer_ += cur_buffer;
      acc_buffer_empty_ = false;

      // Start filling the next buffer in the cycle ...
      //

      cur_idx_++; 
      if( cur_idx_ == cycle_length_ ) cur_idx_ = 0;

      // ... but first subtract this next buffer from the accumulation buffer
      //

      cur_buffer.create( acc_buffer_.get_dimensions().get(), cyc_buffer_.get_data_ptr()+cur_idx_*acc_buffer_.get_number_of_elements() );
      acc_buffer_ -= cur_buffer;

      // Clear new buffer before refilling
      //

      Gadgetron::clear(&cur_buffer);
    }

    cur_sub_idx_++;
    if( cur_sub_idx_ == sub_cycle_length_ ) cur_sub_idx_ = 0;

    return cycle_completed;
  }

  template<class REAL, unsigned int D, bool ATOMICS>
  boost::shared_ptr< cuNDArray<complext<REAL> > > cuSenseBuffer<REAL,D,ATOMICS>::get_accumulated_coil_images()
  {
    std::vector<unsigned int> dims = to_std_vector(matrix_size_);
    dims.push_back(num_coils_);

    acc_image_ = boost::shared_ptr< cuNDArray<_complext> >( new cuNDArray<_complext>(&dims) );
				    
    // Check if we are ready to reconstruct. If not return an image of ones...
    if( acc_buffer_empty_ ){
      fill(acc_image_.get(),_complext(1));
      return acc_image_;
    }

    // Finalize gridding of k-space CSM image (convolution has been done already)
    //

    // Copy accumulation buffer before in-place FFT
    cuNDArray<_complext> acc_copy = acc_buffer_;

    // FFT
    nfft_plan_.fft( &acc_copy, cuNFFT_plan<REAL,D,ATOMICS>::NFFT_BACKWARDS );
    
    // Deapodize
    nfft_plan_.deapodize( &acc_copy );
    
    // Remove oversampling
    crop<_complext,D>( (matrix_size_os_-matrix_size_)>>1, &acc_copy, acc_image_.get() );
    
    //if( normalize ){
    //REAL scale = REAL(1)/(((REAL)cycle_length_-REAL(1))*(REAL)sub_cycle_length_);
    //*acc_image_ *= scale;
    //}
    
    return acc_image_;
  }

  template<class REAL, unsigned int D, bool ATOMICS>
  boost::shared_ptr< cuNDArray<complext<REAL> > > cuSenseBuffer<REAL,D,ATOMICS>::get_combined_coil_image()
  {
    if( csm_.get() == 0x0 ){
      throw std::runtime_error("cuSenseBuffer::get_combined_coil_image: csm not set");
    }

    if( acc_image_.get() == 0x0 ){
      if( get_accumulated_coil_images().get() == 0x0 ){ // This updates acc_image_
	throw std::runtime_error("cuSenseBuffer::get_combined_coil_image: unable to acquire accumulated coil images");
      }
    }
    
    std::vector<unsigned int> dims = to_std_vector(matrix_size_);
    boost::shared_ptr< cuNDArray<_complext> > image( new cuNDArray<_complext>(&dims) );

    E_->set_csm(csm_);
    E_->mult_csm_conj_sum( acc_image_.get(), image.get() );

    return image;
  }

  //
  // Instantiations
  //

  template class EXPORTGPUPMRI cuSenseBuffer<float,2,true>;
  template class EXPORTGPUPMRI cuSenseBuffer<float,2,false>;

  template class EXPORTGPUPMRI cuSenseBuffer<float,3,true>;
  template class EXPORTGPUPMRI cuSenseBuffer<float,3,false>;

  template class EXPORTGPUPMRI cuSenseBuffer<float,4,true>;
  template class EXPORTGPUPMRI cuSenseBuffer<float,4,false>;

  template class EXPORTGPUPMRI cuSenseBuffer<double,2,false>;
  template class EXPORTGPUPMRI cuSenseBuffer<double,3,false>;
  template class EXPORTGPUPMRI cuSenseBuffer<double,4,false>;
}