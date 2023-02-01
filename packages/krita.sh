#!/usr/bin/env bash



source "utils/check_os.sh"

echo "Krita installation"

# Without AppImage
if $(check_ubuntu $1) || [ "pop" == $1 ];
then
  sudo add-apt-repository ppa:kritalime/ppa
  sudo apt install krita
elif $(check_arch $1);
then 
  sudo pacman -S krita
elif $(check_fedora $1);
then
  sudo dnf install krita+
fi

#Add the option to AppImage
