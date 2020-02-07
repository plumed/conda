# Conda packages for Munster2020 tutorial

## Install conda

First you should install conda. In order to do so execute the commands below:

````
wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
# on MacOS replace with:
# wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh
bash ./miniconda.sh -b -f -p /path/to/conda
export PATH="/path/to/conda/bin:$PATH"
source activate base
````

Here `/path/to/conda` should be the path where you want to install conda. You can choose it in your home so that you will have write permission to it.

You might want to use a separate environment just for the Lugano tutorial. You can do it using the following commands

````
conda create --name munster-tutorials
source activate munster-tutorials
````

The second command should be repeated every time you open a new shell.
In case you have already conda installed, by working in a separate environment you will make sure that there
will not be interference between packages specifically needed for this tutorial and packages that you have already installed.

## Install PLUMED

This command installs the latest PLUMED version from conda-forge, together with its python wrappers:

````
conda install -c conda-forge plumed py-plumed
````

On Linux, the command above should install the following packages:

````
  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-0_gnu
  ca-certificates    conda-forge/linux-64::ca-certificates-2019.11.28-hecc5488_0
  certifi            conda-forge/linux-64::certifi-2019.11.28-py38_0
  fftw               conda-forge/linux-64::fftw-3.3.8-nompi_h7f3a6c3_1110
  gawk               conda-forge/linux-64::gawk-5.0.1-h516909a_1
  gsl                conda-forge/linux-64::gsl-2.6-h294904e_0
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.33.1-h53a641e_8
  libblas            conda-forge/linux-64::libblas-3.8.0-14_openblas
  libcblas           conda-forge/linux-64::libcblas-3.8.0-14_openblas
  libffi             conda-forge/linux-64::libffi-3.2.1-he1b5a44_1006
  libgcc-ng          conda-forge/linux-64::libgcc-ng-9.2.0-h24d8f2e_2
  libgfortran-ng     conda-forge/linux-64::libgfortran-ng-7.3.0-hdf63c60_5
  libgomp            conda-forge/linux-64::libgomp-9.2.0-h24d8f2e_2
  liblapack          conda-forge/linux-64::liblapack-3.8.0-14_openblas
  libopenblas        conda-forge/linux-64::libopenblas-0.3.7-h5ec1e0e_6
  libstdcxx-ng       conda-forge/linux-64::libstdcxx-ng-9.2.0-hdf63c60_2
  ncurses            conda-forge/linux-64::ncurses-6.1-hf484d3e_1002
  openssl            conda-forge/linux-64::openssl-1.1.1d-h516909a_0
  pip                conda-forge/noarch::pip-20.0.2-py_2
  plumed             conda-forge/linux-64::plumed-2.6.0-hfcf5afb_2
  py-plumed          conda-forge/linux-64::py-plumed-2.6.0-py38he1b5a44_0
  python             conda-forge/linux-64::python-3.8.1-h357f687_2
  readline           conda-forge/linux-64::readline-8.0-hf8c457e_0
  setuptools         conda-forge/linux-64::setuptools-45.1.0-py38_0
  sqlite             conda-forge/linux-64::sqlite-3.30.1-hcee41ef_0
  tk                 conda-forge/linux-64::tk-8.6.10-hed695b0_0
  wheel              conda-forge/noarch::wheel-0.34.2-py_1
  xdrfile            conda-forge/linux-64::xdrfile-1.1.4-h516909a_0
  xz                 conda-forge/linux-64::xz-5.2.4-h14c3975_1001
  zlib               conda-forge/linux-64::zlib-1.2.11-h516909a_1006
````

The exact versions might be different. Notice however that all the packages are from the `conda-forge` channel.

## Install GROMACS

This command installs a special version of GROMACS 2018.8 pre-patched with PLUMED.
Patching is done in runtime mode, and should by default pick the PLUMED library installed
on conda in the same environment, using the command above. 

````
conda install --strict-channel-priority -c plumed/label/munster -c conda-forge gromacs
````

The `--strict-channel-priority` might be necessary in case your conda install is configured to download packages from `bioconda`. Indeed, `bioconda` contains a version of GROMACS that is **NOT** patched with PLUMED.

On Linux, the command above should install the following packages:

````
  gromacs            plumed/label/munster/linux-64::gromacs-2018.8-hf484d3e_0
  icu                conda-forge/linux-64::icu-64.2-he1b5a44_1
  libhwloc           conda-forge/linux-64::libhwloc-1.11.9-0
  libiconv           conda-forge/linux-64::libiconv-1.15-h516909a_1005
  libxml2            conda-forge/linux-64::libxml2-2.9.10-hee79883_0
````

The exact versions might be different.  Notice however that gromacs comes from the `plumed/label/munster` channel, whereas the required libraries come from `conda-forge`.

Also notice that in order to obtain good performances it is convenient to compile GROMACS on the machine you are running it. You can find out in the PLUMED documention how to patch GROMACS with PLUMED so as to be able to install it from source. For this tutorial, the conda precompiled binaries will be sufficient.


## Install other software that you will need

Using conda you might also install other software that will be used during the workshop.
You will likely need these python packages:

````
conda install -c conda-forge numpy scipy jupyter matplotlib pandas mdanalysis
````

