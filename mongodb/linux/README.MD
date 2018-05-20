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
tar -xzvf scons-3.0.1.tar.gz  
cd scons-3.0.1  
python setup.py install  

## 安装boost
tar xzf boost_1_66_0.tar.gz  
cd boost_1_66_0  
./bootstrap.sh --with-libraries=system,filesystem,log,thread --with-toolset=gcc  
./b2 toolset=gcc cxxflags="-std=c++11"  
./b2 install --prefix=/usr/local/boost  

## 安装mongodb
tar -zxf mongodb-src-r3.6.3.tar.gz  
cd mongodb-src-r3.6.3  
scons all  
scons --prefix=/usr/local/mongodb --full install  
