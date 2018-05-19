# 安装curl
tar zxvf curl-7.32.0.tar.gz 
cd curl-7.32.0 
./configure --prefix=/usr/local/curl --with-ssl=/usr/local/openssl
make
make install
