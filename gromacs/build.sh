#!/bin/bash
set -e

opt=""

if [[ $(uname) == Darwin ]]; then
# CMAKE_OSX_SYSROOT and CMAKE_OSX_DEPLOYMENT_TARGET should be set for cmake to work correctly
  opt="-DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} -DCMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}"
# lapack and blas should be set explicitly otherwise GROMACS might pick a static version of libopenblas
  opt="$opt -DGMX_BLAS_USER=$PREFIX/lib/libblas.dylib -DGMX_LAPACK_USER=$PREFIX/lib/liblapack.dylib"
  LIBS="$LIBS $PREFIX/lib/libhwloc.dylib"
else
# lapack and blas should be set explicitly otherwise GROMACS might pick a static version of libopenblas
  opt="$opt -DGMX_BLAS_USER=$PREFIX/lib/libblas.so -DGMX_LAPACK_USER=$PREFIX/lib/liblapack.so"
  LIBS="$LIBS $PREFIX/lib/libhwloc.so"
fi

$PREFIX/bin/plumed-patch -p --runtime -e gromacs-$PKG_VERSION
mkdir build
cd build
cmake .. \
  $opt \
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_MPI=OFF \
  -DGMX_THREAD_MPI=OFF \
  -DGMX_GPU=OFF \
  -DGMX_SIMD=SSE2 \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make VERBOSE=1 -j $CPU_COUNT
make install
