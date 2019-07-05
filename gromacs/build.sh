#!/bin/bash
set -e
plumed-patch -p --runtime -e gromacs-2018.6 --root=$PREFIX/lib/plumed
mkdir build
cd build
cmake .. \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_INSTALL_RPATH:PATH="${PREFIX}/lib" \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make -j $CPU_COUNT
make install
