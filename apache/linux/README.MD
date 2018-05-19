# 安装apache
tar -xjvf apr-1.5.2.tar.bz2 
tar -xjvf apr-util-1.5.4.tar.bz2
tar -xzvf httpd-2.4.29.tar.gz 
mv apr-1.5.2 httpd-2.4.29/srclib/apr
mv apr-util-1.5.4 httpd-2.4.29/srclib/apr-util

cd httpd-2.4.29
./configure --prefix=/usr/local/apache --with-included-apr --enable-so --enable-deflate=shared --enable-expires=shared --enable-rewrite=shared --enable-static-support --disable-userdir
make
make install

## apache 相关命令
./apachectl start
./apachectl stop
./apachectl restart
./apachectl graceful #通过granceful方式重启
