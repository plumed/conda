# Conda packages for GROMACS and LAMMPS (WIP)

## Install conda


````
wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
# on MacOS replace with:
# wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh
bash ./miniconda.sh -b -f -p /path/to/conda
export PATH="/path/to/conda/bin:$PATH"
source activate base
````

## Install PLUMED

This command installs a special version of PLUMED 2.5.1 that also includes the optional dimred module.

````
conda install -c plumed/label/lugano -c conda-forge plumed
````

Make sure you include the two channels in the right order, so that `plumed/label/lugano` has the priority, since the version
of PLUMED available on conda-forge does not include the dimred module.
On OSX, the command above should install the following packages:

````
  gsl                conda-forge/osx-64::gsl-2.5-ha2d443c_0
  libblas            conda-forge/osx-64::libblas-3.8.0-10_openblas
  libcblas           conda-forge/osx-64::libcblas-3.8.0-10_openblas
  libcxx             conda-forge/osx-64::libcxx-8.0.0-4
  libcxxabi          conda-forge/osx-64::libcxxabi-8.0.0-4
  libgfortran        conda-forge/osx-64::libgfortran-3.0.1-0
  liblapack          conda-forge/osx-64::liblapack-3.8.0-10_openblas
  libopenblas        conda-forge/osx-64::libopenblas-0.3.6-hd44dcd8_4
  llvm-openmp        conda-forge/osx-64::llvm-openmp-8.0.0-h770b8ee_0
  openblas           conda-forge/osx-64::openblas-0.3.6-hd44dcd8_4
  plumed             plumed/label/lugano/osx-64::plumed-2.5.1-h0a44026_3
  xdrfile            conda-forge/osx-64::xdrfile-1.1.4-h01d97ff_0
  zlib               conda-forge/osx-64::zlib-1.2.11-h01d97ff_1005
````

Again, notice that the `plumed` package comes from `plumed/label/lugano`, whereas all the libraries come from `conda-forge`.

## Install GROMACS

This command installs a special version of GROMACS 2018.6 pre-patched with PLUMED.
Patching is done in runtime mode, and should by default pick the PLUMED library installed
on conda in the same environment, using the command above. 

````
conda install -c plumed/label/lugano -c conda-forge gromacs
````

On OSX, the command above should install the following packages:

````
  fftw               conda-forge/osx-64::fftw-3.3.8-mpi_mpich_h6e18f22_1006
  gromacs            plumed/label/lugano/osx-64::gromacs-2018.6-h2b26ce3_0
  icu                conda-forge/osx-64::icu-58.2-h0a44026_1000
  libhwloc           conda-forge/osx-64::libhwloc-1.11.9-0
  libiconv           conda-forge/osx-64::libiconv-1.15-h01d97ff_1005
  libxml2            conda-forge/osx-64::libxml2-2.9.9-hd80cff7_1
  mpi                conda-forge/osx-64::mpi-1.0-mpich
  mpich              conda-forge/osx-64::mpich-3.2.1-ha90c164_1013
  xz                 conda-forge/osx-64::xz-5.2.4-h1de35cc_1001
````

Notice that MPI is installed as a requirement of one of the libraries used by GROMACS, but GROMACS itself
will be installed in non-MPI version (with openMP parallelism enabled).


## Install LAMMPS

This command installs a special version of LAMMPS 2019, June, pre-patched with PLUMED.
Patching is done in runtime mode, and should by default pick the PLUMED library installed
on conda in the same environment, using the command above. 

````
conda install -c plumed/label/lugano -c conda-forge lammps
````

On OSX, the command above should install the following packages:

````
  lammps             plumed/label/lugano/osx-64::lammps-2019.6.5-h2b26ce3_0
  libjpeg-turbo      conda-forge/osx-64::libjpeg-turbo-2.0.2-h1de35cc_0
  libpng             conda-forge/osx-64::libpng-1.6.37-h2573ce8_0
````

