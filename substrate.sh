#!/usr/bin/env bash

if [[ -n $1 ]];
then
  if [ $1 == "ubuntu" ] || [ $1 == "pop" ];
  then
    echo "Ubuntu "
    sudo apt install --assume-yes git clang curl libssl-dev
  fi
  elif [[ $1 == "debian" ]];
  then
    echo "Debian Installation."
  elif [[ $1 == "arch" ] || [ $1 == "manjaro" ]];
  then
    echo "Arch Family Installation"
  fi
  
fi
