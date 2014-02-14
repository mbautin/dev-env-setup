#!/bin/bash

set -e -u -o pipefail -x

# -------------------------------------------------------------------------------- 
# Functions
# -------------------------------------------------------------------------------- 

# Check if the given tarball is OK.
check_tarball() {
  local tarball=$1
  [ -f "${tarball}" ] && tar -tzf "$tarball" >/dev/null
}

top_level_dir_from_tarball() {
  local tarball=$1
  local dir_names_str=$(tar -tzf "$tarball" | cut -d/ -f1 | sort | uniq)
  local dir_names_arr=( $dir_names_str )
  if [ "${#dir_names_arr[@]}" != "1" ]; then
    echo "Too many top-level directories in tarball $tarball" >&2
    exit 1
  fi
  echo "${dir_names_str}"
}

packages=(
curl
git
libxml2-dev
libyaml-dev
openssh-server
vim
wget
zlib1g-dev
)

sudo apt-get install -y "${packages[@]}"

# Turn off dnsmasq caching locally
# http://www.ubuntugeek.com/how-to-disable-dnsmasq-in-ubuntu-12-04precise.html

if [ -f /etc/NetworkManager/NetworkManager.conf ]; then
  sudo sed -i 's/^dns=dnsmasq/#dns=dnsmasq/' /etc/NetworkManager/NetworkManager.conf
  sudo restart network-manager
fi

# Oracle JDK
jdk_tmp_dir="/tmp/oracle_jdk"
mkdir -p "${jdk_tmp_dir}"
cd "${jdk_tmp_dir}"

jdk_tarball=jdk-7u51-linux-x64.tar.gz
if ! check_tarball "${jdk_tarball}"; then
  rm -f "${jdk_tarball}"
  wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" \
    "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/${jdk_tarball}"
fi

# Get the top-level directory name from the tarball.
new_jdk_dir_name=$( top_level_dir_from_tarball "${jdk_tarball}" )

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

# Apache Maven

maven_version=3.0.5
maven_tarball=apache-maven-${maven_version}-bin.tar.gz
maven_url="http://apache.osuosl.org/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz"
maven_tmp_dir="/tmp/maven_download"

mkdir -p "${maven_tmp_dir}"
cd "${maven_tmp_dir}"

if ! check_tarball "${maven_tarball}"; then
  wget "${maven_url}"
fi

maven_dir_name=$( top_level_dir_from_tarball "${maven_tarball}" )

cd /usr/local
if [ ! -d "${maven_dir_name}" ]; then
  sudo tar xzf "${maven_tmp_dir}/${maven_tarball}"
fi

# Set editor

if ! egrep "^EDITOR=" /etc/environment >/dev/null; then
  sudo bash -c '( echo; echo "EDITOR=/usr/bin/vim" ) >>/etc/environment'
fi

# Set JAVA_HOME

if ! egrep "^JAVA_HOME=" /etc/environment >/dev/null; then
  sudo bash -c '( echo; echo "JAVA_HOME=/usr/lib/jvm/default-java" ) >>/etc/environment'
fi

