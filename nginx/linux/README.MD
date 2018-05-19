# 安装nginx

## 安装pcre
tar -xzvf pcre-8.42.tar.gz
cd pcre-8.42
./configure
make
make install

## 安装pcre2
tar -xzvf pcre2-10.31.tar.gz
cd pcre2-10.31
./configure
make
make install

## 安装zlib
tar -xzvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --enable-shared
make
make install
make clean
make distclean

## 安装nginx
tar -xzvf nginx-1.13.3.tar.gz
cd nginx-1.13.3
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-pcre --with-openssl=/usr/local/openssl
make
make install

### error
[/usr/local/openssl//.openssl/include/openssl/ssl.h] Error 127 
解决:
打开nginx源文件下的nginx-1.13.3/auto/lib/openssl/conf文件：
找到这么一段代码：
CORE_INCS="$CORE_INCS $OPENSSL/.openssl/include"
CORE_DEPS="$CORE_DEPS $OPENSSL/.openssl/include/openssl/ssl.h"
CORE_LIBS="$CORE_LIBS $OPENSSL/.openssl/lib/libssl.a"
CORE_LIBS="$CORE_LIBS $OPENSSL/.openssl/lib/libcrypto.a"
CORE_LIBS="$CORE_LIBS $NGX_LIBDL"
修改成以下代码：
CORE_INCS="$CORE_INCS $OPENSSL/include"
CORE_DEPS="$CORE_DEPS $OPENSSL/include/openssl/ssl.h"
CORE_LIBS="$CORE_LIBS $OPENSSL/lib/libssl.a"
CORE_LIBS="$CORE_LIBS $OPENSSL/lib/libcrypto.a"
CORE_LIBS="$CORE_LIBS $NGX_LIBDL"
然后再进行Nginx的编译安装即可
 
### error 
threads_pthread.c:(.text+0x16): undefined reference to `pthread_atfork' 
vim objs/Makefile

before: 
-ldl -lpthread -lpthread -lcrypt -lpcre /install/openssl-1.1.1-pre2/.openssl/lib/libssl.a /install/openssl-1.1.1-pre2/.openssl/lib/libcrypto.a -ldl /install/zlib-1.2.11/libz.a \ 

after: 
-ldl -lcrypt -lpcre /install/openssl-1.1.1-pre2/.openssl/lib/libssl.a /install/openssl-1.1.1-pre2/.openssl/lib/libcrypto.a -ldl /install/zlib-1.2.11/libz.a -lpthread \
