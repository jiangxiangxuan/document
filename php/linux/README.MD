# 安装php
yum -y install libxml2-devel openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel openldap-devel libmcrypt-devel
yum install libXpm-devel.x86_64 -y
yum install libtool -y
yum install expat-devel -y
yum -y install pcre-devel -y
yum install libxml2 -y
yum install libxml2-devel -y
yum install postgresql-devel -y
yum install mysql-devel -y

## 安装zlib
tar -xzvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --enable-shared
make
make install
make clean
make distclean

## 安装freetype
tar xzvf freetype-2.8.1.tar.gz
cd freetype-2.8.1
./configure --prefix=/usr/local/freetype
make
make install
make clean
make distclean
cp /usr/local/freetype/include/freetype2/* /usr/local/include/ -r

## 安装jpegsrc
tar zxvf jpegsrc.v9b.tar.gz
cd jpeg-9b
./configure --prefix=/usr/local/jpeg --enable-shared --enable-static  
make
make install
make clean
make distclean
libtool --finish /usr/local/jpeg/lib  

## 安装libpng
tar zxvf libpng-1.5.30.tar.gz
cd libpng-1.5.30
LDFLAGS="-L/usr/local/lib" CPPFLAGS="-I/usr/local/include" ./configure  --prefix=/usr/local/libpng --enable-shared --enable-static
make
make install
make clean
make distclean

## 安装libgd
tar -xzvf libgd-2.2.3.tar.gz
cd libgd-2.2.3
./configure --prefix=/usr/local/libgd --with-jpeg=/usr/local/jpeg --with-png=/usr/local/libpng --with-zlib --with-freetype=/usr/local/freetype
make
make install
make clean
make distclean

## 安装php
tar -xzvf php-7.1.7.tar.gz
cd php-7.1.7
./configure --prefix=/usr/local/php7.1.7 --with-config-file-path=/usr/local/php7.1.7/etc --with-apxs2=/usr/local/apache/bin/apxs --with-freetype-dir=/usr/local/freetype  --with-jpeg-dir=/usr/local/jpeg  --with-png-dir=/usr/local/libpng --with-gd=/usr/local/libgd --with-pgsql --with-pdo-pgsql --with-mysqli --with-pdo-mysql --with-mysql=shared,mysqlnd --with-xpm-dir=/usr/lib64/ --enable-inline-optimization --disable-debug  #--with-curl=/usr/local/curl
make
make install
cp /home/soft/php-7.1.7/php.ini-development /usr/local/php7.1.7/etc/php.ini

## 安装mysqli ext
cd php-7.1.7/ext/mysqli
/usr/local/php7.1.7/bin/phpize
./configure --with-php-config=/usr/local/php7.1.7/bin/php-config --with-mysql --with-zlib
make
make install
make clean
make distclean

## 安装phpgd ext
cd php-7.1.7/ext/gd
/usr/local/php7.1.7/bin/phpize
./configure --with-php-config=/usr/local/php7.1.7/bin/php-config  --with-jpeg-dir=/usr/local/jpeg  --with-png-dir=/usr/local/libpng   --with-freetype-dir=/usr/local/freetype
make
make install
make clean
make distclean

## 安装phpize ext
git clone https://github.com/nicolasff/phpredis
git clone https://github.com/phpredis/phpredis.git
tar -xzvf phpredis.tar.gz
cd phpredis
/usr/local/php7.1.7/bin/phpize
./configure --with-php-config=/usr/local/php7.1.7/bin/php-config
make
make install
make clean
make distclean

### php配置redis
vim /usr/local/php7.1.7/etc/php.ini
extension="redis.so"

## 安装openssl ext
cd php-7.1.7/ext/openssl
/usr/local/php7.1.7/bin/phpize
./configure --with-php-config=/usr/local/php7.1.7/bin/php-config  --with-curl=/usr/local/openssl
make
make install
make clean
make distclean

### php配置openssl
vim /usr/local/php7.1.7/etc/php.ini
extension=openssl.so

export PKG_CONFIG_PATH=/usr/local/openssl/lib/pkgconfig
export LDFLAGS=-L/usr/local/openssl/lib

## 安装curl ext
cd php-7.1.7/ext/curl
/usr/local/php7.1.7/bin/phpize
./configure --with-php-config=/usr/local/php7.1.7/bin/php-config  --with-curl=/usr/local/curl
make
make install
make clean
make distclean

### php配置curl
vim /usr/local/php7.1.7/etc/php.ini
extension=curl.so
