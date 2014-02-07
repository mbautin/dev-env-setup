#!/bin/bash

set -e -u -o pipefail -x

sudo apt-get install openssh-server vim

# Oracle JDK
jdk_tmp_dir="/tmp/oracle_jdk"
mkdir -p "${jdk_tmp_dir}"
cd "${jdk_tmp_dir}"

jdk_tarball=jdk-7u51-linux-x64.tar.gz
if ! tar -tzf "${jdk_tarball}" >/dev/null; then
  rm -f "${jdk_tarball}"
  wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" \
    "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/${jdk_tarball}"
fi

# Get the top-level directory name from the tarball.
new_jdk_dir_name=$( tar -tzf "${jdk_tarball}" | egrep '^[^/]+/$' | head -1 )

# Strip the trailing "/".
new_jdk_dir_name=${new_jdk_dir_name%/}

jdk_top_dir=/usr/lib/jvm
jdk_target_dir="${jdk_top_dir}/${new_jdk_dir_name}"

if [ ! -d "${jdk_target_dir}" ]; then
  sudo mkdir -p "${jdk_top_dir}"
  cd "${jdk_top_dir}"
  sudo tar xzf "${jdk_tmp_dir}/${jdk_tarball}"
  if [ -h "default-java" ]; then
    sudo unlink default-java
  fi
  sudo ln -s "${new_jdk_dir_name}" default-java
fi

