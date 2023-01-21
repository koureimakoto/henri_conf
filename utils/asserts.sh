#!/usr/bin/env bash

export BASHTEST_GLOBAL_STACK=()

function assert_eq() {
  [ $1 == $2 ]
  BASHTEST_GLOBAL_STACK+=($?)
}

function assert_ne() {
  [ $1 != $2 ]
  BASHTEST_GLOBAL_STACK+=($?)
}

function assert_raw() {
  if [[ $1 == 0 ]] || [[ $1 == 1 ]];
  then
    BASHTEST_GLOBAL_STACK+=($1)
  fi
  echo "Assert Raw Error: Only can pass a boolean value"
  exit 1
}

function clear_stack() {
  for id in ${!BASHTEST_GLOBAL_STACK[@]}
  do
    pop $id
  done
}

function pop() {
  unset BASHTEST_GLOBAL_STACK[$1]
}

function print_stack() {
  for id in "${!BASHTEST_GLOBAL_STACK[@]}";
  do
    status=$( print_status ${BASHTEST_GLOBAL_STACK[$id]} )
    echo "STACK $id: $status"
  done
}

function print_status() {
  if [[ $1 == 0 ]];
  then
    echo "true"
  else
    echo "false"
  fi
}
function stack_size() {
  echo ${#BASHTEST_GLOBAL_STACK[@]}
}