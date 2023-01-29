#!/usr/bin/env bash

MANAGER=""

function __init__() {
  clear
  
  if [[ -z $1 ]];
  then
    filename=$(basename $PWD)
    echo "Invalided arg. Try out: ./$filename <distro: ubuntu | pop | arch>"
    exit 1
  fi

  echo "Installations on $1"
    
}

function __end__() {
  echo "Installed with sucess: $1"
}

function __prepare_installation__() {
  MANAGER=$1
}

function undef_package_manager() {
  echo "Package Manager Undefined"
  exit 1
}

function __install__() {
  if [ $MANAGER == "apt" ];
  then
    sudo apt install $1
  elif [ $MANAGER == "pacman" ];
  then
    sudo pacman -S $1
  elif [ $MANAGER == "" ];
  then
    sudo dnf install $1
  fi
  undef_package_manager
}

function __update__() {
  if [ $MANAGER == "apt" ];
  then
    sudo apt update
  elif [ $MANAGER == "pacman" ];
  then
    sudo pacman -Syu
  elif [ $MANAGER == "" ];
  then
    sudo dnf update
  fi
  undef_package_manager
}
 