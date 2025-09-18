# LCLS Python Environments

A repository for holding yaml files representing conda environments for use on the SLAC network. Environments are built and published using kubernetes jobs with the appropriate OS images. The environments described by the files are as follows:

## python3_rhel7_env

This is the default environment that will be available to anyone logging into a RHEL7 or above box and sourcing the default startup scripts. Intended to be stable, only updated via CATER requests, suitable for running production applications.

## rhel7_devel

Updated via a nightly cron job (10 pm) to obtain more recent versions of packages.

## rocky9_gpu_devel

An environment with the GPU version of PyTorch for running on CUDA capable rocky 9 systems.

## Documentation

For additional documentation including the GitHub actions that support the build and testing process please see here: https://slaclab.github.io/conda-pack-docs/
