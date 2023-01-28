#!/usr/bin/env bash

# ---
# author: Talles F. <koureimakoto+tldr_installer@gmail.com>
# ---

source "utils/init.sh"
source "utils/check_os.sh"

__init__ $1

if   $(check_arch $1);
then
  PARAMETER="-S"
  sudo pacman -S tldr
elif $(check_ubuntu $1);
then
  sudo apt install tldr
else
  echo ""
fi

tldr -u
