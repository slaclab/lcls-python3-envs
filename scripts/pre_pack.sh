#!/bin/bash

# Any commands that should be taken prior to packing up the environment for use.
# This includes disabling binaries for which we want to use the operating system's version rather than conda's version,
# and disabling activate scripts that we don't want modifying our environment.

set -e

# Ensure any dbus commands are run using the version that comes with the operating system
echo "Disabling conda dbus binaries..."
for bin in $(find "$CONDA_PREFIX/bin" -name 'dbus-*' -o -name 'gdbus*' -o -name 'qdbus*'); do
  echo "Renaming $bin -> $bin.donotuse"
  mv "$bin" "$bin.donotuse"
done

# Ensure the conda environment does not modify our EPICS environment variable setup, or our C and C++ build tools
echo "Disabling conda activate scripts we don't want to use..."
ACTIVATE_SCRIPTS=(
  "activate-binutils_linux-64.sh"
  "activate-gcc_linux-64.sh"
  "activate-gxx_linux-64.sh"
  "epics-base_activate.sh"
)

for script in "${ACTIVATE_SCRIPTS[@]}"; do
  if [ -f "$CONDA_PREFIX/etc/conda/activate.d/$script" ]; then
    echo "Renaming $CONDA_PREFIX/etc/conda/activate.d/$script -> $CONDA_PREFIX/etc/conda/activate.d/$script.donotuse"
    mv "$CONDA_PREFIX/etc/conda/activate.d/$script" "$CONDA_PREFIX/etc/conda/activate.d/$script.donotuse"
  fi
done

echo "pre conda-pack setup complete"
