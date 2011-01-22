#ifndef GADGETHEADERS_H
#define GADGETHEADERS_H

#include <ace/Basic_Types.h>

//Data flags
#define GADGET_FLAG_ACQ_END                   (1 << 0) /* 0x01 */
#define GADGET_FLAG_LAST_ACQ_IN_SLICE         (1 << 1) /* 0x02 */
#define GADGET_FLAG_LAST_ACQ_IN_MEAS          (1 << 2) /* 0x04 */
#define GADGET_FLAG_LAST_ACQ_IN_CONCAT        (1 << 3) /* 0x08 */
#define GADGET_FLAG_FIRST_ACQ_IN_SLICE        (1 << 4) /* 0x02 */
#define GADGET_FLAG_FIRST_ACQ_IN_MEAS         (1 << 5) /* 0x04 */
#define GADGET_FLAG_FIRST_ACQ_IN_CONCAT       (1 << 6) /* 0x08 */

enum GadgetMessageID {
  GADGET_MESSAGE_ID_MIN = 0,
  GADGET_MESSAGE_ACQUISITION,
  GADGET_MESSAGE_CONFIGURATION,
  GADGET_MESSAGE_NEW_MEASUREMENT,
  GADGET_MESSAGE_END_OF_SCAN,
  GADGET_MESSAGE_IMAGE,
  GADGET_MESSAGE_INITIALIZATION,
  GADGET_MESSAGE_EMPTY,
  GADGET_MESSAGE_ID_MAX
};
  
struct GadgetMessageIdentifier
{
  ACE_UINT16 id;
};

struct GadgetMessageInitializer
{
  char configuration_file[1024];
};

struct GadgetMessageConfigurator
{
  char configurator_lib[1024];
  char configurator_name[1024];
  ACE_UINT32 configuration_length;
};


struct LoopCounters {
  ACE_UINT16 line;
  ACE_UINT16 acquisition;
  ACE_UINT16 slice;
  ACE_UINT16 partition;
  ACE_UINT16 echo;
  ACE_UINT16 phase;
  ACE_UINT16 repetition;
  ACE_UINT16 set;
  ACE_UINT16 segment;
  ACE_UINT16 channel;
};


struct GadgetMessageAcquisition
{
  ACE_UINT32     flags;
  ACE_UINT32     meas_uid;
  ACE_UINT32     scan_counter;
  ACE_UINT32     time_stamp;
  ACE_UINT16     samples;
  ACE_UINT16     channels;
  float          position[3];
  float          quarternion[4];   
  LoopCounters   idx;
  LoopCounters   min_idx;
  LoopCounters   max_idx;
};

struct GadgetMessageImage
{
  ACE_UINT16     matrix_size[3];
  ACE_UINT16     channels;
  float          position[3];
  float          quarternion[4];
  LoopCounters   data_idx_min;
  LoopCounters   data_idx_max;
  LoopCounters   data_idx_current;
}; 

#endif  //GADGETHEADERS_H
