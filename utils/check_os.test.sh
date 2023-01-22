#!/usr/bin/env bash

filename="${0%.test}"
echo "Init $filename test:"

source "check_os.sh"
source "asserts.sh"

function if_comparation_is_true() {
  result=$(check_os "first" "first")
  assert true $result
} 

function forced_error() {
  result=$(check_os "first" "first")
  assert false $result
}

function if_comparation_is_false() {
  result=$(check_os "first" "second")
  assert false $result
  assert true $result
}
