#!/usr/bin/env bash

clear

if [ ! -n $1 ];
then
  echo "Invalided arg. Try out: ./zsh_install.sh <distro: ubuntu | pop | arch>"
  exit 1
fi

if [ $1 == "ubuntu" ] || [ $1 == "pop" ];
then
  sudo apt install zsh
  chsh -s /bin/zsh
fi
