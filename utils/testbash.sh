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
  rg -o 'function\s+(\w+)' --replace '$1' --no-line-number $1
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
      result=$(list_functions $component)
      echo "functions: $result"
    fi 
  done
}

function is_dir() {
  [ -d $1 ]
}

function is_file() {
  [ -f $1 ]
}

list_files $1