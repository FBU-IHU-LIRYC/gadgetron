# Install script for directory: /home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/benoit/gadgetron_install_dir/gadgetron4_sms/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so.4.1.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/libgadgetron_toolbox_gpuparallelmri.so.4.1.1"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/libgadgetron_toolbox_gpuparallelmri.so.4.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so.4.1.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/usr/local/cuda-10.0/lib64:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/nfft/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/cpu/math:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/fft/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/cpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/log:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial:"
           NEW_RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so"
         RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/libgadgetron_toolbox_gpuparallelmri.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so"
         OLD_RPATH "/usr/local/cuda-10.0/lib64:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/nfft/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/cpu/math:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/fft/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/cpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/log:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial:"
         NEW_RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpuparallelmri.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xmainx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/gadgetron" TYPE FILE FILES
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/b1_map.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/sense_utilities.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/htgrappa.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/senseOperator.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuSenseOperator.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuCartesianSenseOperator.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuNonCartesianSenseOperator.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuNonCartesianKtSenseOperator.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuSpiritOperator.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuBuffer.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuSenseBuffer.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuSenseBufferCg.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuSpiritBuffer.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/gpupmri_export.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/test_gpu_benoit.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuZeroFilling.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/mri/pmri/gpu/cuSubSampling.h"
    )
endif()

