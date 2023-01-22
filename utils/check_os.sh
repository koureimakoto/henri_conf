#!/usr/bin/env bash



function check_os() {
  if [[ ! -n $1 ]] || [[ ! -n $2 ]];
  then
    echo "Empty arguments"
    exit 1
  fi
  
  if [ $1 == $2 ];
  then
    echo "true"
  else
    echo "false"
  fi
}

function check_ubuntu {
  $( check_os "ubuntu" $1 )
}
