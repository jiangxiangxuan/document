# 安装gcc

## 安装依赖库
yum install -y glibc-devel bison flex texinfo build-essential  

### 安装gmp
tar jxvf gmp-4.3.2.tar.bz2  
cd gmp-4.3.2  
./configure -prefix=/usr/local/gmp  
make  
make install  

### 安装mpfr
tar jxvf mpfr-2.4.2.tar.bz2  
cd mpfr-2.4.2  
./configure --prefix=/usr/local/mpfr --with-gmp=/usr/local/gmp  
make  
make install  

### 安装mpc
tar -zxf mpc-0.8.1.tar.gz  
cd mpc-0.8.1  
./configure --prefix=/usr/local/mpc --with-gmp=/usr/local/gmp --with-mpfr=/usr/local/mpfr  
make  
make install  


## 编译安装
wget http://ftp.gnu.org/gnu/gcc/gcc-8.1.0/gcc-8.1.0.tar.gz  
tar -xzvf gcc-8.1.0.tar.gz  

cd gcc-8.1.0  
./contrib/download_prerequisites  

mkdir gcc-build; cd $_  

../configure -enable-threads=posix -enable-checking=release -enable-languages=c,c++ -disable-multilib --with-gmp=/usr/local/gmp --with-mpfr=/usr/local/mpfr --with-mpc=/usr/local/mpc    

make -j4  
make install  
source /etc/profile  
