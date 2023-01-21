#!/usr/bin/env bash

# source "stack.sh"

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
  vector=()
  line=$(read < /tmp/bash_test_tmp_file.test)
  for char in $line; 
  do
    vector+=("$char")
  done

  echo "$vector" 
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
  if [[ $1 -eq 0 ]] || [[ $1 -eq 1 ]];
  then
    attach_result $1
  else
    echo "Assert Raw Error: Only can pass a boolean value"
    exit 1
  fi
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
  for id in "${!ASSERT_STACK[@]}";
  do
    status=$( print_status ${ASSERT_STACK[$id]} )
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
  ASSERT_STACK=$(read_bash_test_file)
  if [ ${#ASSERT_STACK[@]} -eq 0 ];
  then
    echo "Empty Stack"
    return 1
  fi
  
  for id in "${!ASSERT_STACK[@]}";
  do 
    if [ $id -eq 0 ];
    then
      printf " OK "
    else
      printf " Error "
      break
    fi
  done
  return 0
}
