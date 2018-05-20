# 安装mongodb

## 安装js
tar -xzvf js-1.8.0-rc1.tar.gz  
cd js/src  
export CFLAGS="-DJS_C_STRINGS_ARE_UTF8"  
make -f Makefile.ref  
JS_DIST=/usr make -f Makefile.ref export  

## 安装pcre
tar -zxvf pcre-8.42.tar.gz  
cd pcre-8.42  
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

## 安装scons
见scons安装  

## 安装boost
见boost安装  

## 安装mongodb
下载mongodb:wget https://fastdl.mongodb.org/src/mongodb-src-r3.6.4.tar.gz?_ga=2.37127072.1648078642.1526802035-698304878.1526802035  
tar -zxf mongodb-src-r3.6.4.tar.gz  
cd mongodb-src-r3.6.4  
scons all  
scons --prefix=/usr/local/mongodb --full install  
