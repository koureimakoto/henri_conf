#!/usr/bin/env bash

function henri_init() {
  if [[ ! -n $1 ]];
  then
    filename=$(basename $PWD)
    echo "Invalided arg. Try out: ./$filename <distro: ubuntu | pop | arch>"
    exit 1
  fi  
  echo "saiu"
}


function os_name() {
  OS=$( echo $1 | tr '[:lower:]' '[:upper:]' )
  echo "Installing "
}
 