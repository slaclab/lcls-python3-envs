#!/bin/bash

# All tests to be run to verify the environment built correctly and will work as expected at run time
git clone --depth=1 https://github.com/xopt-org/Xopt.git
pushd Xopt
pytest
popd
