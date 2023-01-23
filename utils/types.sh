#!/usr/bin/env bash

function type_int() {
  if [[ $1 =~ ^-?[0-9]+$ ]];
  then
    echo "true"
  else
    echo "false"
  fi
}

function type_float() {
  if [[ $1 =~ ^-?([0-9]+\.[0-9]+)$ ]];
  then
    echo "true"
  else
    echo "false"
  fi
}

function type_bool() {
  case "$1" in
    true |0|"true"|"0"|'t'|'T'|false|1|"false"|"1"|'f'|'F') echo "true";;
    *) echo "false"
  esac
}

function type_fd() {
  if $(type_int $1);
  then
    # Chat GPT assist
    fd=$1
    if head -c 1 <&"$fd" &>/dev/null;
    then
      echo "true"
    else
      echo "false"
    fi
  else
    echo "false"
  fi
}

function type_of() {
  if [[ ! -n $1 ]];
  then
    echo "Try out using: type_of $first"
  fi

  if   $(type_int $1);
  then
    echo "int"
  elif $(type_float $1);
  then
    echo "float"
  elif $(type_bool $1);
  then
    echo "bool"
  elif $(type_fd $1);
  then
    echo "file"
  else
    echo "text"
  fi
}

# type_fd $1