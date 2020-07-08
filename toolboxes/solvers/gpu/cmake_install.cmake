# Install script for directory: /home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xmainx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so.4.1.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/libgadgetron_toolbox_gpusolvers.so.4.1.1"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/libgadgetron_toolbox_gpusolvers.so.4.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so.4.1.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/usr/local/cuda-10.0/lib64:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/cpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/log:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial:"
           NEW_RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xmainx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so"
         RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/libgadgetron_toolbox_gpusolvers.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so"
         OLD_RPATH "/usr/local/cuda-10.0/lib64:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/gpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/core/cpu:/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/log:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial:"
         NEW_RPATH ".:/home/benoit/gadgetron_install_dir/gadgetron4_sms/local/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgadgetron_toolbox_gpusolvers.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xmainx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/gadgetron" TYPE FILE FILES
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuSbCgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuSbcCgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuCgPreconditioner.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuLwSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuLbfgsSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuSbLwSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuSbcLwSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuCgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuNlcgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuGpBbSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/hoCuCgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/hoCuNlcgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/hoCuSbcCgSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/hoCuGpBbSolver.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/cuSolverUtils.h"
    "/home/benoit/gadgetron_install_dir/gadgetron4_sms/mrprogs/gadgetron/toolboxes/solvers/gpu/gpusolvers_export.h"
    )
endif()

