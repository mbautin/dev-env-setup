#!/bin/bash

set -e -u -o pipefail -x

curl -sSL https://get.rvm.io | bash -s stable
ruby_version=2.1.2

set +u +x
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm install ${ruby_version}

