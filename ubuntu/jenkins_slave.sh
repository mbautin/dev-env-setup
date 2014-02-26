#!/bin/bash

set -e -u -o pipefail -x

sudo apt-get install -y jenkins

sudo -u jenkins -i bash -c "curl -sSL https://get.rvm.io | bash -s stable"

ruby_version=1.9.3-p484

# Some libraries that may be necessary for Ruby gems such as psych (YAML parser), etc.
debian_packages=(
libxml2-dev
libxslt1-dev
libyaml-dev
zlib1g-dev
)

sudo apt-get install -y "${debian_packages[@]}"

sudo -u jenkins -i rvm install ${ruby_version} --autolibs=disabled
