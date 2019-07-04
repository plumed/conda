#!/bin/bash
set -e
plumed-patch -p --runtime -e gromacs-2018.6
mkdir build
cd build
# GMX_LIB_INSTALL_DIR=lib - make sure library is installed in lib and not lib64
cmake .. \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make -j $CPU_COUNT
make install
