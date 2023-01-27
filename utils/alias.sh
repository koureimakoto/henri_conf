#!/usr/bin/env bash

ZSHRC="~/.zshrc"
BASHRC="~/.bashrc"
BASH_ALIASES="~/.bash_aliases"

function set_alias() {
  if [ -f $ZSHRC ];
  then
    echo "alias $1=$2" >> $ZSHRC
  elif [ -f $BASHRC ];
  then
    echo "alias $1=$2" >> $BASH_ALIASES
  fi
}
