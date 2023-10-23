#!/bin/bash
conda remove --force --offline --yes jax
conda remove --force --offline --yes jaxlib

git clone https://github.com/ChristopherMayes/Xopt.git
cd Xopt
pytest
