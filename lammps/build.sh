#!/bin/bash
set -e

# Since this version is compiled with MPI, it should not pass a communicator to PLUMED
cat src/USER-PLUMED/fix_plumed.cpp | grep -v setMPIComm > src/USER-PLUMED/fix_plumed.cpp.fix
mv src/USER-PLUMED/fix_plumed.cpp.fix src/USER-PLUMED/fix_plumed.cpp

opt=""

# Fix the name of the PLUMED kernel on OSX
if [[ $(uname) == Darwin ]]; then
  cat cmake/CMakeLists.txt | sed "s/libplumedKernel.so/libplumedKernel.dylib/" > cmake/CMakeLists.txt.fix
  mv cmake/CMakeLists.txt.fix cmake/CMakeLists.txt
  cat lib/plumed/Makefile.lammps.runtime | sed "s/libplumedKernel.so/libplumedKernel.dylib/" > lib/plumed/Makefile.lammps.runtime.fix
  mv lib/plumed/Makefile.lammps.runtime.fix lib/plumed/Makefile.lammps.runtime
# CMAKE_OSX_SYSROOT and CMAKE_OSX_DEPLOYMENT_TARGET should be set for cmake to work correctly
  opt="-DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} -DCMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}"
fi

LIBS="$LIBS -llapack -lblas"

make -C src lib-plumed args="-p $PREFIX -m runtime"

mkdir build
cd build
cmake -DBUILD_MPI=no \
      -DPKG_MANYBODY=yes \
      -DPKG_KSPACE=yes \
      -DPKG_MOLECULE=yes \
      -DPKG_RIGID=yes \
      -DPKG_USER-PLUMED=yes \
      $opt \
      ../cmake
make VERBOSE=1 -j${CPU_COUNT}

# cd src
# make yes-kspace
# make yes-molecule
# make yes-rigid
# make yes-manybody
# make yes-user-plumed
# make -j${CPU_COUNT} serial

cp lmp_serial $PREFIX/bin/lmp_serial
