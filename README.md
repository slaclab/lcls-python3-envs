# LCLS Python Environments

A repository for holding yaml files representing conda environments for use on the SLAC network. Also includes workflows for creating and testing the environments for deployment to RHEL6 and RHEL7 machines. The environments described by the files are as follows:

## default-rhel7-environment

This is the environment that will be available to anyone logging into a RHEL7 box and sourcing the default startup scripts. Intended to be stable, only updated via CATER requests, suitable for running production applications.

## default-rhel6-environment

This is the old default environment, only for use on any remaining machines still running RHEL6.

## nightly-rhel6-environment

This environment will also run on RHEL6 machines, but is rebuilt with the latest (compatible) version of each package nightly via a [GitHub cron job](https://github.com/slaclab/lcls-python3.8-env/blob/main/.github/workflows/publish_rhel6_nightly.yml). As such, it is intended mainly for development and testing, and is not suitable for a production applicaiton needing a stable environment.

## nightly-rhel7-environment

Similar profile to the other nightly environment, except built against RHEL7 to get more recent versions of packages that are not supported by RHEL 6. Updated via [cron job](https://github.com/slaclab/lcls-python3.8-env/blob/main/.github/workflows/publish_rhel7_nightly.yml)  as well.

## Documentation

For additional documentation including the GitHub actions that support the build and testing process please see here: https://slaclab.github.io/conda-pack-docs/
