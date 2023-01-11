#!/usr/bin/env bash

clear

if [[ -n $1 ]];
then

  if [ $1 == "ubuntu" ] || [ $1 == "pop" ];
  then
    echo "Ubuntu "
    sudo apt install build-essential
    sudo apt install --assume-yes git clang curl make libssl-dev protobuf-compiler
  elif [ $1 == "debian" ];
  then
    echo "Debian Installation."
    sudo apt install build-essential
    sudo apt install --assume-yes git clang curl libssl-dev llvm libudev-dev make protobuf-compiler
  elif [ $1 == "arch" ] || [ $1 == "manjaro" ];
  then
    echo "Arch Family Installation"
    pacman -Syu --needed --noconfirm curl git clang make protobuf
  else
    echo "Define a OS for installation: ./substrate.sh ubuntu"
    exit 1
  fi

  if [ ! -x "$(command -v rustc)" ];
  then
    echo "Rust has not been installed yet"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y

    RUSTUP=~/.cargo/bin/rustup

    $RUSTUP default stable
    $RUSTUP update
    $RUSTUP update nightly
    $RUSTUP target add wasm32-unknown-unknown --toolchain nightly
    
    rustup target add wasm32-unknown-unknown
  fi  
fi
