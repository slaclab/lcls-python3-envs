#!/bin/bash

# Temporary fix for a jax incompatibility, can be removed once that is resolved
conda remove --force --offline --yes jax
conda remove --force --offline --yes jaxlib
pip install jax

# All tests to be run to verify the environment built correctly and will work as expected at run time
git clone https://github.com/ChristopherMayes/Xopt.git
pushd Xopt
pytest
