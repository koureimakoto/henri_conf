#!/usr/bin/env bash

# ---
# coauthor: Talles F. <koureimakoto+rust_analyzer_installer@gmail.com>
# ---

# RUST ANALYZER DOC
#    This installation use the user's cargo path to install the binary language
# server. If you need use  /usr/local/bin or  ~/.local/bin should be change the
# LOCAL_PATH below.

NAME=rust-analyzer
LOCAL_PATH=~/.cargo/bin
RUST_URL=https://github.com/rust-lang/$NAME/releases/latest/download
RUST_ANALYZER_RELEASE=$NAME-x86_64-unknown-linux-gnu.gz
RUST_ANALYZER_PATH=$LOCAL_PATH/$NAME
TMP=--output-dir 

mkdir -p $LOCAL_PATH
curl  -L $RUST_URL/$RUST_ANALYZER_RELEASE | gunzip -c - > $RUST_ANALYZER_PATH
sudo  chmod +x $RUST_ANALYZER_PATH
