#!/usr/bin/env bash


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
  # Chat GPT assist
  functions=$(rg -o 'function\s+(\w+)' --replace '$1' --no-line-number $1)
  # $array_functions
  # IFS=$'\n' read -r -a arr <<< "$functions"
    echo $functions > mapfile -t arr
  echo "$arr"
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
        source $component
        result=($(list_functions $component))
        exec_concurrency_test $component $result
      fi
    fi 
  done
}

function exec_concurrency_test() {
  arr=$2
  for cmd in ${arr[@]};
  do
    result=$($cmd)
    echo "   $1::$cmd"
  done
}


function is_dir() {
  [ -d $1 ]
}

function is_file() {
  [ -f $1 ]
}

list_files $1