#!/usr/bin/env bash

source "asserts.sh"

declare -a FUNC_ARRAY=()
declare -a TEST_ARRAY=()

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
  replace=$1
  functions=$(rg -o 'function\s+(\w+)' --replace '${1}' --no-line-number $replace ) 
  # functions+='\n'
  mapfile -t FUNC_ARRAY < <(printf "$functions")
  # read -d '' -r -a arr <<< "$functions"
  # arr=($functions)
  
  # echo "${arr[@]}"
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
          # result=($(list_functions $component))
          list_functions $component
          exec_concurrency_test $component
        remove_bash_test_file
      fi
    fi 
  done
}

function exec_concurrency_test() {
  if [ ${#FUNC_ARRAY[@]} -eq 0 ];
  then
    echo "$1 has no function to unit test"
  else
    path=$1
    path=${path%.*}
    for cmd in "${FUNC_ARRAY[@]}";
    do
      result=$($cmd)
      printf "$path::$cmd -> "
      check_stack
      echo ""
    done
  fi
}


function is_dir() {
  [ -d $1 ]
}

function is_file() {
  [ -f $1 ]
}

list_files $1

# ARR=($(list_functions check_os.test.sh))

# echo ${ARR[@]}

# for i in "${!ARR[@]}"; do
#   echo "${ARR[$i]}"
# done