#!/usr/bin/env bash
#---
# Project: Auto install my Helix config if Helix is installed 
# Created: 2023-01-04
# Author : Talles F. <koureimakoto+helix_themes_install@gmail.com>
# License: GNU/ GPL v3.0
#---

if [ -x "$(command -v hx)" ];
then # If the helix editor does not run
    ROOT=~/.config/helix
    CONFIG_FILE=config.toml
    
    HELIX_CONFIG_STATUS=$ROOT/$CONFIG_FILE
    echo $HELIX_CONFIG_STATUS
    if [ -f $HELIX_CONFIG_STATUS ];
    then
        echo "The Helix config has been created"
    else
        ln helix_config_file.toml $ROOT/$CONFIG_FILE
        echo "Created a configured file"
    fi 
    
    # ---
    DEFAULT_THEME="helix_dark_theme.toml"
    
    HELIX_THEME_STATUS=$ROOT/themes/$DEFAULT_THEME
    if [ -f $HELIX_THEME_STATUS ];
    then # If the file is not fould: [-f path ] or test -f path
        echo "This theme has been installed"
        exit 1
    fi
    
    mkdir -p ~/.config/helix/themes
    ln $DEFAULT_THEME $ROOT/themes/$DEFAULT_THEME
    echo "Created a symbolic of $DEFAULT_THEME"
    echo "Warning:  You shouldn't modify the  linked  file into"
    echo "\'~/config/helix/runtime/theme/this_theme\', it is just"
    echo "a symbolic link any modification could be lost."
else
    echo "Before installing this theme, you need to install Helix Editor"
fi

