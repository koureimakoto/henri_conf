#!/usr/bin/env bash

ZSHRC=~/.zshrc
BASHRC=~/.bashrc
BASH_ALIASES=~/.bash_aliases

function set_alias() {
  if [[ -f $ZSHRC ]];
  then
    printf "\nalias $1=\"$2\"" >> $ZSHRC
  fi
  
  if [[ -f $BASHRC ]];
  then
    printf "\nalias $1=\"$2\"" >> $BASH_ALIASES
  fi
}
