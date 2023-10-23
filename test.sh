#!/bin/bash
conda remove --force --offline --yes jax
conda remove --force --offline --yes jaxlib

pip install jax==0.4.16
pip install jaxlib==0.4.19
pip install jaxtyping==0.2.21

git clone https://github.com/ChristopherMayes/Xopt.git
cd Xopt
pytest
