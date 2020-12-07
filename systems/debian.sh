#!/bin/sh

set -e

if
  (! command -v force_print >/dev/null 2>&1) ||
  ! $(force_print 3 a b >/dev/null 2>&1) ||
  test "$(force_print 3 a b)" != "a  b";
then
  printf "Please run this script through \"install.sh\" instead"
  exit 1
fi

. systems/base.sh

update() {
  sudo_cmd apt update -y
  if test $1 = "upgrade"; then
    sudo_cmd apt full-upgrade -y
  fi
}

install_dpkg_packages() {
  # local path=$(deps "$name.deb")
  # cmd curl -sSL $url -o $path
  # sudo_cmd dpkg --install $path
  return
}

install_packages() {
  local apt_packages=""
  local dpkg_packages=""
  for package in $@; do
    local manager=$(printf "%s" "$package" | cut -d'|' -f1)
    local name=$(printf "%s" "$package" | cut -d'|' -f2-)

    if test "$manager" = "apt"; then
      apt_packages=$(_add_item "$apt_packages" " " "$name")
    elif test "$manager" = "dpkg"; then
      dpkg_packages=$(_add_item "$dpkg_packages" " " "$name")
    fi
  done

  sudo_cmd apt install --no-install-recommends -y $apt_packages
  install_dpkg_packages $dpkg_packages
}

use_apt() {
  local package="$1"
  add_package apt "$package"
}

use_dpkg() {
  local name="$1"
  local url="$2"
  add_package dpkg "$name" "$url"
}
