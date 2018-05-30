# 安装mysql
yum install ncurses-devel  
yum install libaio  

## 安装ncurses
tar -xzvf ncurses-6.0.tar.gz  
cd ncurses-6.0  
export CPPFLAGS="-P"   
./configure --with-shared --without-debug --without-ada --enable-overwrite    
make  
make install  

## 安装boost
见boost安装  

## 安装mysql
下载mysql:wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.11.tar.gz  
mkdir -p /usr/local/mysql   
mkdir -p /usr/local/mysql/data  
mkdir /var/run/mariadb/  
mkdir /var/log/mariadb/  
mkdir /usr/local/mysql/logs  
touch /var/log/mariadb/mariadb.log  
groupadd mysql  
useradd -r -g mysql mysql  
chown -R mysql:mysql /var/run/mariadb/  
chown -R mysql:mysql /var/log/mariadb/  
chown -R mysql:mysql /usr/local/mysql/logs  
tar -zxv -f mysql-8.0.11.tar.gz  
cd mysql-8.0.11  
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/usr/local/mysql/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/usr/local/mysql/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/boost  

### 安装mysql参数说明： 
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql //安装目录   
-DINSTALL_DATADIR=/usr/local/mysql/data //数据库存放目录   
-DDEFAULT_CHARSET=utf8 　　　　//使用utf8字符   
-DDEFAULT_COLLATION=utf8_general_ci //校验字符   
-DEXTRA_CHARSETS=all 　　　　//安装所有扩展字符集   
-DENABLED_LOCAL_INFILE=1 　　 //允许从本地导入数据  
make  
make install  

### mysql配置
chown -R mysql:mysql /usr/local/mysql  
vim /usr/local/mysql/etc/my.cnf  

[client]  
port = 3306  
socket = /usr/local/mysql/logs/mysql.sock  

[mysqld]  
character_set_server=utf8  
init_connect='SET NAMES utf8'  
basedir=/usr/local/mysql  
datadir=/usr/local/mysql/data  
socket=/usr/local/mysql/logs/mysql.sock  
log-error=/usr/local/mysql/logs/mysqld.log  
pid-file=/usr/local/mysql/logs/mysqld.pid  
lower_case_table_names = 1 #不区分大小写  
#sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION  
max_connections=5000  
default-time_zone = '+8:00'  
default_authentication_plugin=mysql_native_password  


### 初始化mysql数据库
yum install libaio  
touch /var/log/mysqld.log  
chmod 777 /var/log/mysqld.log  
chown mysql:mysql /var/log/mysqld.log  
/usr/local/mysql/bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --lc_messages_dir=/usr/local/mysql/share --lc_messages=en_US  

### 查看mysql初始密码
cat /var/log/mysqld.log  
最后一行：root@localhost: 这里就是初始密码  

### mysql环境变量 
vim /etc/profile  
export PATH=/usr/local/mysql/bin:$PATH  
source /etc/profile  

### 启动mysql服务
cd /usr/local/mysql  
#./bin/mysqld_safe --defaults-file=./etc/my.cnf --user=mysql &  
./bin/mysqld --defaults-file=./etc/my.cnf --user=mysql &  

### 修改mysql初始密码
#./bin/mysqld_safe --defaults-file=./etc/my.cnf --skip-grant-tables --skip-networking --user=mysql &  
./bin/mysqld --defaults-file=./etc/my.cnf --skip-grant-tables --skip-networking --user=mysql &  

./bin/mysql -h localhost -P 3306 --socket=/usr/local/mysql/mysql.sock -u root -p  
use mysql;  
set global read_only=0;  
flush privileges;  
set global read_only=1;  
flush privileges;  

#set password=password('新密码');  
#grant all privileges on *.* to '新用户名'@'%' identified by '新密码';  

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '新密码';  
update user set Host='%' where User='root';  
flush privileges;  
