#!/usr/bin/env bash 


BLENDER_3_4_LIST=$(wget -q -O - https://mirrors.ocf.berkeley.edu/blender/release/Blender3.4/)

declare -a VERSIONS_ARRAY=()
VERSION_REGEX='([3-9]{1}\.[1-9]+\.[0-9]+)'
match=$(rg -o "blender-$VERSION_REGEX-linux-x64.tar.xz" <<< $BLENDER_3_4_LIST | sort -u )

mapfile -t VERSIONS_ARRAY < <(printf "$match")

MAJOR=0
TO_DOWNLOAD=""
for el in ${VERSIONS_ARRAY[@]};
do
  buff=$(rg -o $VERSION_REGEX <<< $el | sed -e 's/\.//g')
  
  if [[ $buff -gt $MAJOR ]];
  then
    MAJOR=$buff
    TO_DOWNLOAD=$el
  fi
done
echo $MAJOR
echo $TO_DOWNLOAD

wget https://mirrors.ocf.berkeley.edu/blender/release/Blender3.4/$TO_DOWNLOAD -O blender_down
