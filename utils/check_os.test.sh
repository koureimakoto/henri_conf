#!/usr/bin/env bash

clear

filename="${0%.test}"
echo "Init $filename test:"



source "check_os.sh"

function if_comparation_is_true() {
  if check_os "first" "first" ];
  then
    echo "The comparation is True"
  else
    echo "The comparation is False"
  fi
} 




#EXEC TEST
if_comparation_is_true