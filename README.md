# Conda packages for GROMACS and LAMMPS (WIP)

## Install conda


````
wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
# on MacOS replace with:
# wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh
bash ./miniconda.sh -b -f -p /path/to/conda
export PATH="/path/to/conda/bin:$PATH"
````

## Install plumed
````
conda install -c conda-forge plumed
````

## Install gromacs
````
conda install -c conda-forge -c plumed/label/lugano gromacs
````


