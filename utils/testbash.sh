#!/usr/bin/env bash

source "asserts.sh"

function stack() {
  echo "Func Stack ${FUNCNAME[1]}"
}

function self_file_name() {
  "${0%.test}"
}

function test_stack() {
  echo "test"
}

function get_file_name() {
  basename $1
}

function list_functions() {
  if [ $# -eq 0 ];
  then
    echo "Missing argument"
    exit 1
  fi
  # Chat GPT assist
  functions=$(rg -o 'function\s+(\w+)' --replace '$1' --no-line-number $1 | sed 's/ /\n/g') 
  # mapfile -t arr | echo "$functions" & exit 0
  arr=($functions)

  echo "${arr[@]}"
}

function list_files() {
  for file in $1/*
  do
    component="$(get_file_name $file)"
    if is_dir $component;
    then
      echo "Directory: $component"
    elif is_file $component;
    then
      if [[ "$component" == *.test.sh ]];
      then
        new_bash_test_file
          source $component
          result=($(list_functions $component))
          exec_concurrency_test $component $result
          check_stack
          echo ""
        remove_bash_test_file
      fi
    fi 
  done
}

function exec_concurrency_test() {
  arr=("$2")
  if [ ${#arr[@]} -eq 0 ];
  then
    echo "Empty Array"
  else
    for cmd in ${arr[@]};
    do
      result=$("$cmd")
      printf "$1::$cmd"
    done
  fi
}


function is_dir() {
  [ -d $1 ]
}

function is_file() {
  [ -f $1 ]
}

# list_files $1

list_functions check_os.test.sh