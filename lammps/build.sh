#!/bin/bash
set -e

# Serial
mkdir build_serial
cd build_serial
cmake -D BUILD_MPI=OFF -D BUILD_OMP=OFF -D PKG_USER-PLUMED=ON -D PLUMED_MODE=runtime  ../cmake
make -j${CPU_COUNT}
cp lmp $PREFIX/bin/lmp_serial
cd ..
