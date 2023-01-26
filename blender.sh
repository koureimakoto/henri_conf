#!/usr/bin/env bash 



# Blender is too heavy to download anytime that running the script, so I check
# if it has been installed.
if [ -x "$(command -v blender)" ];
then
  echo "Blender was intalled"
  exit 1
fi

BLENDER_URL="https://mirrors.ocf.berkeley.edu/blender/release/Blender3.4"
URL_RESPONSE=$(wget -q -O - $BLENDER_URL)

declare -a VERSIONS_ARRAY=()
# Version Regex: num.num.num
VERSION_REGEX='([3-9]{1}\.[1-9]+\.[0-9]+)'
# Blende Regex: only blender tar
BLENDER_REGEX="blender-$VERSION_REGEX-linux-x64.tar.xz"
MATCH=$(rg -o $BLENDER_REGEX <<< $URL_RESPONSE | sort -u )

mapfile -t VERSIONS_ARRAY < <(printf "$MATCH")

# Check the last released version to download
LAST_RELEASED=0
TO_DOWNLOAD=""
for version in ${VERSIONS_ARRAY[@]};
do
  buff=$(rg -o $VERSION_REGEX <<< $version | sed -e 's/\.//g')
  
  if [[ $buff -gt $LAST_RELEASED ]];
  then
    LAST_RELEASED=$buff
    TO_DOWNLOAD=$version
  fi
done

echo "The last released is $TO_DOWNLOAD"

wget $BLENDER_URL/$TO_DOWNLOAD -O blender_down.tar.xz
tar -xvf blender_down.tar.xz -C /tmp/blender_tar

if [ ! -d /usr/local/blender ];
then
  sudo mv /tmp/blender_tar/* /usr/local/blender
fi

if [ -f "~/.bashrc"];
then
  echo 'alias blender="/usr/local/blender/blender"' >> ~/.bashrc
fi

if [ -f "~/.zshrc"];
then
  echo 'alias blender="/usr/local/blender/blender"' >> ~/.zshrc
fi
