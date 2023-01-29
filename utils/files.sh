#!/usr/bin/env bash

function get_file_name() {
  basename $1
}

function is_dir() {
  [ -d $1 ]
}

function is_file() {
  [ -f $1 ]
}