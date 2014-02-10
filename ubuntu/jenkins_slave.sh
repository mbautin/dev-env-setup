#!/bin/bash

set -e -u -o pipefail -x

sudo apt-get install -y jenkins

sudo -u jenkins -i bash -c "curl -sSL https://get.rvm.io | bash -s stable"

ruby_version=1.9.3-p484

# Some libraries that may be necessary for Ruby gems such as psych (YAML parser), etc.
sudo apt-get install -y libyaml-dev zlib1g-dev

sudo -u jenkins -i rvm install ${ruby_version} --autolibs=disabled

