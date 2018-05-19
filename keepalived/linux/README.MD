# 安装keepalived
yum -y install libnl libnl-devel
yum install -y libnfnetlink-devel
yum install -y libnl3.x86_64
yum install -y libnl3-devel.x86_64
yum install -y libnfnetlink.x86_64 
yum install -y libnfnetlink-devel.x86_64

## 安装m4
tar -xzvf m4-1.4.9.tar.gz
cd m4-1.4.9
./configure
make
make install

## 安装bison
tar -xzvf bison-2.7.91.tar.gz
cd bison-2.7.91
./configure
make
make install

## 安装flex
tar -xzvf flex-2.6.0.tar.gz
cd flex-2.6.0
./configure
make
make install

## 安装libnl
tar -xzvf libnl-3.4.0.tar.gz
cd libnl-3.4.0
./configure --enable-shared --enable-static ### --sysconfdir=/etc --prefix=/usr/local/libnl
make
make install

## 安装keepalived
tar -zxvf keepalived-1.4.2.tar.gz
cd keepalived-1.4.2/
./configure --prefix=/usr/local/keepalived
make
make install

### 启动
/usr/local/keepalived/sbin/keepalived -f /usr/local/keepalived/etc/keepalived/keepalived.conf
