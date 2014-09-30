#!/bin/bash

set -e -u -o pipefail -x
cd `dirname $0`
if ! grep run_from_bashrc.sh ~/.bashrc >/dev/null; then
  echo >>~/.bashrc
  echo ". $PWD/run_from_bashrc.sh" >>~/.bashrc
fi

