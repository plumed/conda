#!/bin/bash
set -e

ls -l /Library/Developer/CommandLineTools/SDKs/ || echo not found
ls -l /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/ || echo not found

plumed-patch -p --runtime -e gromacs-2018.6
mkdir build
cd build
cmake .. \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MaxOSX.sdk \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make -j $CPU_COUNT
make install
