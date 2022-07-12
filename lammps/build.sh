#!/bin/bash
set -e

if [[ $(uname) == Darwin ]]; then
  export SDKROOT="${CONDA_BUILD_SYSROOT}"
fi

# remove check on plumed version
sed "s/api_version *> *[0-9][0-9]*/false/" src/PLUMED/fix_plumed.cpp > src/PLUMED/fix_plumed.cpp.fix
mv src/PLUMED/fix_plumed.cpp.fix src/PLUMED/fix_plumed.cpp


mkdir build
cd build
cmake -DBUILD_MPI=yes \
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

