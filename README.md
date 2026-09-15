# LCLS Python Environments

A repository for holding yaml files representing conda environments for use on the SLAC network. Environments are built and published using kubernetes jobs with the appropriate OS images. The environments described by the files are as follows:

## python3_rhel7_env

This is the default environment that will be available to anyone logging into a RHEL7 or above box and sourcing the default startup scripts. Intended to be stable, only updated via CATER requests, suitable for running production applications.

## rhel7_devel

Updated via a nightly cron job (10 pm) to obtain more recent versions of packages.

## rocky9_gpu_devel

An environment with the GPU version of PyTorch for running on CUDA capable rocky 9 systems.

## Environment definitions

Environments that have been migrated to [pixi](https://pixi.sh) are defined by a `pixi.toml` in a directory named after the
environment (for example `rhel7_devel/pixi.toml`). The nightly build solves that manifest fresh each night and saves the
resulting `pixi.lock` next to the published tarball. Each manifest sets `exclude-newer = "7d"`, so a conda-forge or PyPI
release is not picked up until it has been published for at least 7 days. Packages installed from git are not delayed.
Environments not yet migrated are still defined by an `environment.yml` file at the top level and built with mamba.

## Documentation

For additional documentation around how these environments are built, and the nightly environment in particular, see here: https://confluence.slac.stanford.edu/spaces/ppareg/pages/476119856/Nightly+Python+Environment
