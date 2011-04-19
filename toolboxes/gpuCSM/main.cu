#include "b1_map.hcu"
#include "hoNDArray_fileio.h"
#include "cuNDArray.h"
#include "ndarray_device_utilities.hcu"
#include "NFFT.h"
#include "check_CUDA.h"

#include <cutil.h>
#include <cuComplex.h>
#include <iostream>

using namespace std;

int main( int argc, char** argv) 
{
  hoNDArray<float_complex> host_data = read_nd_array<float_complex>("data/raw_data.cplx");
  hoNDArray<float> host_traj = read_nd_array<float>("data/co.real");
  hoNDArray<float> host_weights = read_nd_array<float>("data/weights.real");

  host_data.squeeze();
  host_traj.squeeze();
  host_weights.squeeze();
  
  if( !(host_data.get_number_of_dimensions() == 1 || host_data.get_number_of_dimensions() == 2) || 
      !(host_weights.get_number_of_dimensions() == 1  || host_weights.get_number_of_dimensions() == 2 ) ||
      host_traj.get_number_of_dimensions() != 2 ){
    
    printf("\nInput data is not two-dimensional. Quitting!\n");
    exit(1);
  }
  
  if( host_data.get_size(0) != host_weights.get_size(0) ){
    printf("\nInput data dimensions mismatch between sample data and weights. Quitting!\n");
    exit(1);
  }
  
  if( host_data.get_size(0) != host_traj.get_size(1) || host_traj.get_size(0) != 2 ){
    printf("\nInput trajectory data mismatch. Quitting!\n");
    exit(1);
  }
  
  // Matrix sizes
  const uintd2 matrix_size = uintd2(128,128);
  const uintd2 matrix_size_os = uintd2(128,128);

  // Kernel width
  const float W = 5.5f;

  // No fixed dimensions
  uintd2 fixed_dims = uintd2(0,0);

  // Get trajectory dimensions 'floatd2' style
  vector<unsigned int> traj_dims = host_traj.get_dimensions();
  traj_dims.erase(traj_dims.begin());
  cuNDArray<float> _traj(host_traj); 
  cuNDArray<floatd2> traj; traj.create(traj_dims, (floatd2*)_traj.get_data_ptr());
  
  cuNDArray<float_complex> data(host_data);
  cuNDArray<float> weights(host_weights);

  unsigned int num_batches = (data.get_number_of_dimensions() == 2) ? data.get_size(1) : 1;
  
  // Setup result image
  vector<unsigned int> image_dims = cuNDA_toVec(matrix_size); 
  if( num_batches > 1 ) image_dims.push_back(num_batches);
  cuNDArray<float_complex> image; image.create( image_dims );
  
  // Initialize plan
  NFFT_plan<float,2> plan( matrix_size, matrix_size_os, fixed_dims, W );

  // Time calls
  unsigned int timer; cutCreateTimer(&timer);
  double time;

  printf("\npreprocess..."); fflush(stdout);
  cutResetTimer( timer ); cutStartTimer( timer );

  // Preprocess
  bool success = plan.preprocess( (cuNDArray<vectord<float,2> >*) &traj, NFFT_plan<float,2>::NFFT_PREP_ALL );
    
  cudaThreadSynchronize(); cutStopTimer( timer );
  time = cutGetTimerValue( timer ); printf("done: %.1f ms.", time ); fflush(stdout);

  printf("\nNFFT_H..."); fflush(stdout);
  cutResetTimer( timer ); cutStartTimer( timer );
  
  // Gridder
  if( success )
    success = plan.compute( (cuNDArray<real_complex<float> >*) &data, (cuNDArray<real_complex<float> >*) &image, &weights, NFFT_plan<float,2>::NFFT_BACKWARDS );
  
  cudaThreadSynchronize(); cutStopTimer( timer );
  time = cutGetTimerValue( timer ); printf("done: %.1f ms.", time ); fflush(stdout);

  printf("\nCSM estimation..."); fflush(stdout);
  cutResetTimer( timer ); cutStartTimer( timer );

  auto_ptr< cuNDArray<real_complex<float> > > csm = estimate_b1_map<float,2>( (cuNDArray<real_complex<float> >*) &image );
  
  cudaThreadSynchronize(); cutStopTimer( timer );
  time = cutGetTimerValue( timer ); printf("done: %.1f ms.", time ); fflush(stdout);

  CHECK_FOR_CUDA_ERROR();

  if( !success ){
    printf("\nNFFT failed. Quitting.\n");
    exit(1);
  }

  //
  // Output result
  //

  hoNDArray<real_complex<float> > host_csm = csm->to_host();
  hoNDArray<float_complex> host_image = image.to_host();
  hoNDArray<float> host_norm_csm = cuNDA_norm<float, real_complex<float> >(csm.get())->to_host();
  hoNDArray<float> host_norm_image = cuNDA_norm<float, float_complex>(&image)->to_host();

  write_nd_array<real_complex<float> >( host_csm, "csm.cplx" );
  write_nd_array<float_complex>( host_image, "result.cplx" );
  write_nd_array<float>( host_norm_csm, "csm.real" );
  write_nd_array<float>( host_norm_image, "result.real" );

  if( num_batches > 1 ) {
    hoNDArray<float> host_rss = cuNDA_rss<float, float_complex>(&image, 2)->to_host();
    write_nd_array<float>( host_rss, "result_rss.real" );
  }

  printf("\n", time ); fflush(stdout);
  return 0;
}
