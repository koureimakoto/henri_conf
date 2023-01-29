#!/usr/bin/env bash

relative_root=$(fdfind henri_conf ~/)

source $relative_root/utils/files.sh
source $relative_root/utils/init.sh

function list_files() {
  # Execute only one update
  # __update__ $3

  __init__ $2
  __prepare_installation__ $3
  # Get all file inside packages directory and install all components inside
  for file in $1/*
  do
    # file="$(get_file_name $file)"
    if   is_dir  $file;
    then
      echo "Directory: $file"
    elif is_file $file;
    then
    ./$file
    fi 
  done
  __end__ $2
}
