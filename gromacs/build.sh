#!/bin/bash
plumed patch -e gromacs-2019.2
mkdir build
cd build
cmake .. \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DGMX_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make -j $CPU_COUNT
make install
