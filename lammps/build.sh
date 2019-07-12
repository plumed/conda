#!/bin/bash
set -e

echo before
sed "s/buildflag = args.build/buildflag = args.build is not None/" lib/plumed/Install.py > lib/plumed/Install.py.tmp
mv lib/plumed/Install.py.tmp lib/plumed/Install.py
echo after
cd src
make lib-plumed args="-p $PREFIX -m runtime"
make yes-kspace
make yes-molecule
make yes-rigid
make yes-manybody
make yes-user-plumed
make -j${CPU_COUNT} serial
cp lmp_serial $PREFIX/bin/lmp_serial
