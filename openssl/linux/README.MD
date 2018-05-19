# 安装openssl
tar -xzvf openssl-1.1.1-pre4.tar.gz
cd openssl-1.1.1-pre4/
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl/ssl shared #zlib
make depend
make
make install

## 拷贝openssl库
cp /usr/local/openssl/lib/libssl.so.1.0.0 /usr/lib/
cp /usr/local/openssl/lib/libcrypto.so.1.0.0 /usr/lib/
cp /usr/local/openssl/lib/libssl.so.1.0.0 /usr/lib64/
cp /usr/local/openssl/lib/libcrypto.so.1.0.0 /usr/lib64/

## OpenSSL生成证书
openssl genrsa -out privtkey.pem 1024/2038
openssl genrsa -des3 -out privtkey.pem 1024/2048
openssl req -new -key privtkey.pem -out cert.csr
openssl req -new -nodes -key privtkey.pem -out cert.csr
openssl req -new -x509 -key privtkey.pem -out cacert.pem -days 1095
