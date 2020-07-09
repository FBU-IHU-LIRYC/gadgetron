#include "EmptyImageGadget.h"

namespace Gadgetron{
int EmptyImageGadget
::process(GadgetContainerMessage<ISMRMRD::ImageHeader>* m1,
	  GadgetContainerMessage< hoNDArray< std::complex<float> > >* m2)
{
  //It is enough to put the first one, since they are linked

   // std::cout << " coucou" << std::endl;

  if (this->next()->putq(m1) == -1) {
    m1->release();
    GERROR("AcquisitionPassthroughGadget::process, passing data on to next gadget");
    return -1;
  }

  return 0;
}
GADGET_FACTORY_DECLARE(EmptyImageGadget)
}


