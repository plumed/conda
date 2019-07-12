#!/bin/bash
set -e

cat src/USER-PLUMED/fix_plumed.cpp | grep -v setMPIComm > src/USER-PLUMED/fix_plumed.cpp.fix
mv src/USER-PLUMED/fix_plumed.cpp.fix src/USER-PLUMED/fix_plumed.cpp

if [[ $(uname) == Darwin ]]; then
echo "A"
  cat cmake/Modules/Packages/USER-PLUMED.cmake | sed "s/libplumedKernel.so/libplumedKernel.dylib/" > cmake/Modules/Packages/USER-PLUMED.cmake.fix
echo "A"
  mv cmake/Modules/Packages/USER-PLUMED.cmake.fix cmake/Modules/Packages/USER-PLUMED.cmake
echo "A"
  cat lib/plumed/Makefile.lammps.runtime | sed "s/libplumedKernel.so/libplumedKernel.dylib/" > lib/plumed/Makefile.lammps.runtime.fix
echo "A"
  mv lib/plumed/Makefile.lammps.runtime.fix lib/plumed/Makefile.lammps.runtime
echo "A"
fi

cd src
make lib-plumed args="-p $PREFIX -m runtime"
make yes-kspace
make yes-molecule
make yes-rigid
make yes-manybody
make yes-user-plumed
make -j${CPU_COUNT} serial
cp lmp_serial $PREFIX/bin/lmp_serial
