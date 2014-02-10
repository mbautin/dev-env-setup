#!/bin/bash

# Instructions for Ubuntu 13.10 from
# http://docs.docker.io/en/latest/installation/ubuntulinux/

set -e -u -o pipefail -x

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker

# http://docs.docker.io/en/latest/installation/ubuntulinux/#giving-non-root-access

# Add the docker group if it doesn't already exist.
if ! egrep "^docker:" /etc/group; then
  sudo groupadd docker
fi

# Add the connected user "${USER}" to the docker group.
# Change the user name to match your preferred user.
# You may have to logout and log back in again for
# this to take effect.
sudo gpasswd -a ${USER} docker

# Restart the Docker daemon.
sudo service docker restart

