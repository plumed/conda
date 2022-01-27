#!/bin/bash
set -e

opt=""

if [[ $(uname) == Darwin ]]; then
  export SDKROOT="${CONDA_BUILD_SYSROOT}"
# lapack and blas should be set explicitly otherwise GROMACS might pick a static version of libopenblas
  opt="$opt -DGMX_BLAS_USER=$PREFIX/lib/libblas.dylib -DGMX_LAPACK_USER=$PREFIX/lib/liblapack.dylib"
  LIBS="$LIBS $PREFIX/lib/libhwloc.dylib"
else
# lapack and blas should be set explicitly otherwise GROMACS might pick a static version of libopenblas
  opt="$opt -DGMX_BLAS_USER=$PREFIX/lib/libblas.so -DGMX_LAPACK_USER=$PREFIX/lib/liblapack.so"
  LIBS="$LIBS $PREFIX/lib/libhwloc.so"
fi

$PREFIX/bin/plumed-patch -p --runtime -e gromacs-$PKG_VERSION

# this is to fix a missing header file in gromacs 2020
for file in $(find src -type f -name "*.cpp")
do
{
  echo "#include <limits>" ;
  cat $file
} > __tmp__
mv __tmp__ $file
done

mkdir build
cd build
cmake .. \
  $opt \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=ON \
  -DGMXAPI=OFF \
  -DGMX_THREAD_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make VERBOSE=1
make install
