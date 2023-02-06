#!/usr/bin/env bash

source utils/check_os.sh
source utils/alias.sh

# set_alias bat batcat
# set_alias nam tldr
# set_alias sl  exa

if check_ubuntu $1;
then
  XXXXX=oi
  #set_alias update 'sudo apt update'
elif check_arch $1;
then
  set_alias update 'sudo pacman -Syu'
elif check_fedora $1;
then
  set_alias update 'sudo dnf update'
fi