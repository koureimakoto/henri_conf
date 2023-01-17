#!/usr/bin/env bash

clear

if [[ ! -n $1 ]];
then
  echo "Invalided arg. Try out: ./zsh_install.sh <distro: ubuntu | pop | arch>"
  exit 1
fi

function os_name() {  
  OS=$(echo $1 | tr '[:lower:]' '[:upper:]')
  echo "Installing ZSH on $OS"
}

if [ $1 == "ubuntu" ] || [ $1 == "pop" ];
then
  os_name $1
  # sudo apt update
  # sudo apt install zsh git
  # sudo chsh -s $(which zsh)
  # cp .henri_zshrc ~/.zshrc
elif [ $1 == "arch" ];
then
  echo "Installing ZSH on $OS"
  sudo pacman update
  sudo pacman -S zsh
  sudo chsh -s $(which zsh)
  cp .henri_zshrc ~/.zshrc
fi

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# ln henri.zhs-theme ~/.oh-my-zsh/themes/henri.zsh-theme
