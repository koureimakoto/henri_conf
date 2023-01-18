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

function list_files() {
  for file in $1/*
  do
    component="$(get_file_name $file)"
    if is_dir $component;
    then
      echo "Directory: $component"
    fi 
  done
}

function is_dir() {
  [ -d $1 ]
}

function is_file() {
  [ -f $1 ]
}

# (?!(declare -f)) [a-zA-Z]+
# res=$(declare -F)
# echo $res | sed "s/declare -f //g"

list_files $PWD