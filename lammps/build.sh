#!/bin/bash
set -e

if [[ $(uname) == Darwin ]]; then
  export SDKROOT="${CONDA_BUILD_SYSROOT}"
fi


make -C src lib-plumed args="-p $PREFIX -m runtime"

mkdir build
cd build
cmake -DBUILD_MPI=no \
      -DPKG_MANYBODY=yes \
      -DPKG_KSPACE=yes \
      -DPKG_MOLECULE=yes \
      -DPKG_RIGID=yes \
      -DPKG_EXTRA-DUMP=yes \
      -DPKG_EXTRA-FIX=yes \
      -DPKG_PLUMED=yes \
      -DPLUMED_MODE=runtime \
      ../cmake
make VERBOSE=1
cp lmp $PREFIX/bin/lmp

