#!/bin/bash
set -e

# Since this version is not compiled with MPI, it should not pass a communicator to PLUMED
# cat src/USER-PLUMED/fix_plumed.cpp | grep -v setMPIComm > src/USER-PLUMED/fix_plumed.cpp.fix
# mv src/USER-PLUMED/fix_plumed.cpp.fix src/USER-PLUMED/fix_plumed.cpp

opt=""

if [[ $(uname) == Darwin ]]; then
# Fix the name of the PLUMED kernel on OSX

# cmake:
  cat cmake/CMakeLists.txt | sed "s/libplumedKernel.so/libplumedKernel.dylib/" > cmake/CMakeLists.txt.fix
  mv cmake/CMakeLists.txt.fix cmake/CMakeLists.txt

# make:
  cat lib/plumed/Makefile.lammps.runtime | sed "s/libplumedKernel.so/libplumedKernel.dylib/" > lib/plumed/Makefile.lammps.runtime.fix
  mv lib/plumed/Makefile.lammps.runtime.fix lib/plumed/Makefile.lammps.runtime

# fix sysroot
  export SDKROOT="${CONDA_BUILD_SYSROOT}"
fi

# blas and lapack are not required when PLUMED is linked shared or runtime:
cat cmake/CMakeLists.txt | sed "s/ OR PKG_USER-PLUMED//" > cmake/CMakeLists.txt.fix
mv cmake/CMakeLists.txt.fix cmake/CMakeLists.txt

make -C src lib-plumed args="-p $PREFIX -m runtime"

mkdir build
cd build
cmake -DBUILD_MPI=no \
      -DPKG_MANYBODY=yes \
      -DPKG_KSPACE=yes \
      -DPKG_MOLECULE=yes \
      -DPKG_RIGID=yes \
      -DPKG_USER-PLUMED=yes \
      -DPLUMED_MODE=runtime \
      $opt \
      ../cmake
make VERBOSE=1
cp lmp $PREFIX/bin/lmp

# cd src
# make yes-kspace
# make yes-molecule
# make yes-rigid
# make yes-manybody
# make yes-user-plumed
# make serial
# cp lmp_serial $PREFIX/bin/lmp_serial
