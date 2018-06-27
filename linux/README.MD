# 安装linux基础库
yum install -y lsof  
yum install -y iptraf  
yum install -y dstat  
yum install -y wget
yum install -y lrzsz  
yum install -y autoconf

yum install -y gcc  
yum install -y gcc-c++ libstdc++-devel  
yum install -y gdb  

## 安装sysstat
tar zxvf sysstat-11.7.2.tar.gz  
cd sysstat-11.7.2  
./configure  
make  
make install  

## 安装iotop
tar xvf iotop-0.6.tar.gz  
cd iotop-0.6  
python setup.py build  
python setup.py install  

## 查看磁盘IO命令
iostat -d -x /dev/sda3 2  
iostat -d -k 1 10         #查看TPS和吞吐量信息(磁盘读写速度单位为KB)  
iostat -d -m 2            #查看TPS和吞吐量信息(磁盘读写速度单位为MB)  
iostat -d -x -k 1 10      #查看设备使用率（%util）、响应时间(await)  
iostat -c 1 10            #查看cpu状态  
