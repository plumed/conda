#!/bin/bash
set -e

cd src
make lib-plumed args="-p $PREFIX -m runtime"
make yes-kspace
make yes-molecule
make yes-rigid
make yes-manybody
make yes-user-plumed
make -j${CPU_COUNT} serial
cp lmp_serial $PREFIX/bin/lmp_serial
