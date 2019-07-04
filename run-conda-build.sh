#!/bin/bash

set -e

conda-build -c conda-forge $1

ls -l $CONDA_HOME/conda-bld/
ls -l $CONDA_HOME/conda-bld/$TRAVIS_OS_NAME-64

