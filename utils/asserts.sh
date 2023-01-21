#!/usr/bin/env bash

export BASHTEST_GLOBAL_STACK

function assert_eq() {
  [ $1 == $2 ]
  BASHTEST_GLOBAL_STACK+=$?
}

function assert_ne() {
  [ $1 != $2 ]
  BASHTEST_GLOBAL_STACK+=$?
}

function assert_raw() {
  if [ $1 == "true"] || [ $1 == "false" ];
  then
    BASHTEST_GLOBAL_STACK+=$1
  fi
  echo "Assert Raw Error: Only can pass a boolean value"
  exit 1
}

function clear_stack() {
  size=${#BASHTEST_GLOBAL_STACK[@]}
  for id in ${BASHTEST_GLOBAL_STACK[@]}
  do
    pop $id
  done
}

function pop() {
  unset BASHTEST_GLOBAL_STACK[$1]
}