#!/usr/bin/env bash



function check_os() {
  if [[ ! -n $1 ]] || [[ ! -n $2 ]];
  then
    echo "Empty arguments"
    exit 1
  fi
  
  [ $1 == $2 ]
}

function check_ubuntu {
  return $( check_os "ubuntu" $1 )
}
