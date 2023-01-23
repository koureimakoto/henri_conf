#!/usr/bin/env bash

# ---
# author: Talles F. <koureimakoto+tldr_installer@gmail.com>
# ---

# Clean Installation
clear



if [[ -n $1 ]];
then
    if [[ $1 != "use" ]];
    then
        echo "---"
        echo "[ERROR]"
        echo " - - - Type: use <your packager installer info>"
        echo "---"
        exit 1
    fi
    
    PARAMETER=""
    if [[ -n $2 ]];
    then
        if [[ $2 == "pacman" ]];
        then
            PARAMETER="-S"
        elif [[ $2 == "apt" || $2 == "apt-get" ]];
        then
                PARAMETER="install"
        else
            echo "Which package installer do you want?"
            echo "You have written: $2"
            exit 1
        fi
    fi

    
    echo "Using personal package to install: $2"
    sudo $2 $PARAMETER tldr
else
    echo "Generic Installation"
    sudo apt install tldr
fi

tldr -u
