#!/bin/bash

set -e

echo "Disabling conda dbus binaries..."
for bin in $(find "$CONDA_PREFIX/bin" -name 'dbus-*' -o -name 'gdbus*' -o -name 'qdbus*'); do
  echo "Renaming $bin -> $bin.donotuse"
  mv "$bin" "$bin.donotuse"
done

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
