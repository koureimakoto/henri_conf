#!/usr/bin/env bash

# source "stack.sh"
source "types.sh"

declare -a ASSERT_ARRAY=()

function new_bash_test_file() {
  touch /tmp/bash_test_tmp_file.test
}

function remove_bash_test_file() {
  rm /tmp/bash_test_tmp_file.test
}

function attach_result() {
  echo $1 >> /tmp/bash_test_tmp_file.test
}

function read_bash_test_file() {
  ASSERT_ARRAY=()
  while read line; 
  do
    ASSERT_ARRAY+=("$line")
  done < /tmp/bash_test_tmp_file.test 
}

function assert_eq() {
  [ $1 == $2 ]
  ASSERT_STACK+=($?)
}

function assert_ne() {
  [ $1 != $2 ]
  ASSERT_STACK+=($?)
}

function assert() {
  local response
  if   [ $1 == true ];
  then
    response=0
  elif [ $1 == false ];
  then
    response=1
  else
    echo "The first argument must be set true or false"
    exit 1
  fi

  case "$2" in
    true |0|"true" |"0"|'t') attach_result $(($response^0));;
    false|1|"false"|"1"|'f') attach_result $(($response^1));;
    *) echo "Assert Raw Error: Only can pass a boolean value using: true|false : 0|1 : \"true\"|\"false\" : \"0\"|\"1\""
      echo "$3"
      exit 1;;
  esac
}

function clear_stack() {
  for id in ${!ASSERT_STACK[@]}
  do
    pop $id
  done
}

function pop() {
  unset ASSERT_STACK[$1]
}

function print_stack() {
  for id in "${!ASSERT_ARRAY[@]}";
  do
    status=$( print_status ${ASSERT_ARRAY[$id]} )
    echo "STACK $id: $status"
  done
}

function print_status() {
  if [[ $1 == 0 ]];
  then
    echo "true"
  else
    echo "false "
  fi
}
function stack_size() {
  echo ${#ASSERT_STACK[@]}
}

function check_stack() {
  read_bash_test_file
  if [ ${#ASSERT_ARRAY[@]} -eq 0 ];
  then
    echo "Empty Stack"
    return 1
  fi
  
  local status=" OK "
  for id in "${ASSERT_ARRAY[@]}";
  do 
    if [[ $id != 0 ]];
    then
      status=" Error "
      break
    fi
  done
  echo $status
}

function compare() {
  if [[ "$(type_of $1)" == "$(type_of $2)" ]];
  then
    if $(type_int $1);
    then
      if [[ $1 -eq $2 ]]
      then
        echo "true"
      else
        echo "false"
      fi
    elif $(type_float $1);
    then
      readonly FLT_EPSILON=0.00000001
      # Chat GPT assist

      local RHS
      local LHS

      if [[ $1 > $2 ]];
      then
        RHS=$1
        LHS=$2
      else
        RHS=$2
        LHS=$1
      fi

      if [[ $(echo "$RHS - $LHS < $FLT_EPSILON" | bc) -eq 1 ]];
      then
        echo "true"
      else
        echo "false"
      fi
    fi
  fi
}

compare $1 $2