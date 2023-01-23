#!/usr/bin/env bash

filename="${0%.test}"
echo "Init $filename test:"

source "check_os.sh"
source "asserts.sh"

function if_comparation_is_true() {
  result=$(check_os "first" "first")
  assert true $result
} 

function if_comparation_is_false() {
  result=$(check_os "first" "second")
  assert false $result
}

function if_is_ubuntu() {
  result=$(check_ubuntu "ubuntu")
  assert true $result
}

function if_is_not_ubuntu() {
  result=$(check_ubuntu "arch")
  assert false $result
}

function if_is_arch() {
  result=$(check_arch "arch")
  assert true $result
}

function if_is_not_arch() {
  result=$(check_arch "fedora")
  assert false $result
}

function if_is_fedora() {
  result=$(check_fedora "fedora")
  assert true $result
}

function if_is_not_ubuntu() {
  result=$(check_fedora "ubuntu")
  assert false $result
}

