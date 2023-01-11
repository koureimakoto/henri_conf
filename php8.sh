#!/usr/bin/env bash

clear

if [ ! -n $1 ];
then
  echo "Empty argument! Try out: ./php8.sh <ubuntu|pop|fedora>"
fi

if [ "ubuntu" == $1 ] || [ "pop" == $1 ];
then
  SQLITE_PATH=/usr/src/sqlite
  PHP_PATH=/opt/php8
  
  echo "PHP 8 Installation for $1"

  sudo systemctl stop apache2

  # Pear installation and SQLITE3, PHP Setup
  sudo apt install \
       php-pear      systemtap-sdt-dev libicu-dev   \
       libmcrypt-dev libpcre3          libpcre3-dev \
       libxml2       libxml2-dev       libxslt1.1   \
       libxslt1-dev  libjpeg62-dev     libpng-dev   \
       libonig-dev   libzip-dev        libtool-bin 

  # SQLITE3 Installation
  sudo mkdir -p $SQLITE_PATH
  cd   $SQLITE_PATH
  sudo wget -c https://www.sqlite.org/2022/sqlite-autoconf-3400100.tar.gz -O sqlite.tar.gz

  sudo tar  xvfz sqlite.tar.gz 
  cd   sqlite-autoconf-*/
  sudo ./configure
  sudo make
  sudo make install
  cd -

  # PHP Installation
  sudo mkdir -p $PHP_PATH
  cd   /usr/src
  sudo wget https://www.php.net/distributions/php-8.2.1.tar.gz -O php82.tar.gz
  sudo tar  -xzvf php82.tar.gz
  cd   php-8.2.1

  # obs.: --with-pdo.. and pgsql =[path] are depedent on PostgreSQL version and
  # path installation: It need the path to acess pg_config dir.
  sudo ./configure           --prefix=/opt/php8                  --exec-prefix=/opt/php8 \
       --enable-mbstring     --enable-ftp                        --enable-exif           \
       --enable-pcntl        --enable-intl                       --enable-opcache        \
       --enable-pdo          --enable-debug                      --enable-dtrace         \
       --enable-xml          --enable-cgi                        --enable-cli            \
       --enable-shared       --with-apxs2=/usr/bin/apxs2                                 \
       --with-pgsql=/usr/lib/postgresql/15/bin                                           \
       --with-pdo-pgsql=/usr/lib/postgresql/15/bin                                       \
       --with-xsl=/usr       --with-zlib-dir=/usr                --with-external-pcre    \
       --with-jpeg           --with-zip  --with-pear=/usr 

  sudo make
  sudo make test
  sudo make install
  sudo build/shtool install -c ext/phar/phar.phar $PHP_PATH/bin
  sudo ln -s -f phar.phar $PHP_PATH/bin/phar

  sudo cp php.ini-development $PHP_PATH/php.ini

  libtool --finish /usr/src/php-8.2.1/libs
fi
 