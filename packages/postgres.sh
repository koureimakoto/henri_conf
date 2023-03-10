#!/usr/bin/env bash

clear

source "utils/check_os.sh"

if [[ ! -n $1 ]];
then
  echo "Invalided arg. Try out: ./postgresql.sh <distro: ubuntu | pop | arch>"
  exit 1
fi

if $(check_ubuntu $1) || [ "pop" == $1 ];
then

  # OS dependences
  sudo apt update
  sudo apt install build-essential binutils apt-transport-https wget 

  PG_APT_LIST=/etc/apt/sources.list.d/pgdg.list
  PG_REPOS="deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main"
  PG_URL_KEY="https://www.postgresql.org/media/keys/ACCC4CF8.asc"
  
  echo "PostgreSQL installation for $1"
  echo "Install the public key for PostgreSQL"
  sudo sh -c "echo $PG_REPOS > $PG_APT_LIST"
  wget --quiet -O - $PG_URL_KEY | sudo apt-key add -

  echo "Install the public key for PGAdmin4"
  curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
  sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

  echo "Install PosgreSQL and PGAdmin"
  sudo apt update
  sudo apt -y install postgresql php-pgsql libpq-dev pgadmin4-desktop

  /etc/init.d/postgresql start

  sudo -i -u postgres psql -c "ALTER USER postgres PASSWORD '1234';"
fi
