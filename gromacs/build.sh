#!/bin/bash
set -e

find /Applications/Xcode.app -name MacOKSX.sdk

plumed-patch -p --runtime -e gromacs-2018.6
mkdir build
cd build
cmake .. \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make -j $CPU_COUNT
make install
