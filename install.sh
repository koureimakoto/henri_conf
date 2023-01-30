#!/usr/bin/env bash

# exa is a new option to ls
# duf is a more visual option to df
# fd-find using fdfind to find
# bashtop is a fantastic and beatiful option to top and htop
# bat, using batcat is a beatiful cat version
# ripgrep is a modern software to replace de old grep 

source utils/engine.sh

# Prerequirements to install all of the next packages
sudo apt install exa duf ncdu fd-find bashtop bat ripgrep vim clamav clamtk
# sudo pacman -S clamav clamtk
# sudo dnf install clamav clamtk


# Create a Invidual file to install Krita
# or appimage option with alias
# sudo add-apt-repository ppa:kritalime/ppa
# sudo apt install krita
# sudo dnf upgrade --refresh
# sudo dnf install flatpak -y
# sudo pacman -S krita

# sudo add-apt-repository ppa:videolan/stable-daily
# sudo apt-get install vlc

# kmymoney appimage
# natron 
# kdnlive
# docker
# obs studio
# Any nice password manager

# Install packages that has important configuration
list_files pack_test ubuntu apt
