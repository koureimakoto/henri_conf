#!/usr/bin/env bash

clear

echo "Apache 2 installation:"

if [[ ! -n $1 ]];
then
  echo "Empty parameter! Try out: ./apache.sh <distro: ubuntu | pop | arch>"
  exit 1
fi

if [ "ubuntu" == $1 ] || [ "pop" == $1 ];
then
  echo "Apache 2 installation for $1"
  sudo apt update
  sudo apt install apache2

  sudo bash -c "printf \"# HENRI AUTO CONFIG\nInclude /etc/apache2/httpd.conf\" >> /etc/apache2/apache2.conf"
  mv henri_httpd.conf /etc/apache2/httpd.conf

  sudo systemctl enable apache2 apache2-dev
  sudo systemctl start  apache2 apache2-dev  
elif [ "fedora" == $1 ];
then
  echo "Apache 2 installation for Fedora"
  sudo yum install httpd
  sudo systemctl enable httpd httpd-dev
  sudo systemctl start  httpd httpd-dev
else
  echo "Invalid argument! Try out: ./apache.sh <ubuntu|pop|fedora>"
fi