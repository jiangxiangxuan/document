# mysql主从配置

master: 192.168.1.110  
slave:  192.168.1.111  

## master 配置

### 创建给 slave 登录用的用户名密码
#GRANT REPLICATION SLAVE ON *.* TO 'backup'@'192.168.1.111' IDENTIFIED BY '123456';  
CREATE USER 'backup'@'%' IDENTIFIED BY '123456';#创建用户  
GRANT REPLICATION SLAVE ON *.* TO 'backup'@'%';#授权  
flush privileges;  

### 创建同步数据库 
create database testdb default charset utf8;  

### 配置master my.cnf
[client]  
port = 3306  
socket = /usr/local/mysql/logs/mysql.sock  

[mysqld]  
port=3306  
server-id=1    #主机id,整数  
log-bin=mysql-bin  
read-only=0  #主机读写权限，读写都可以  
binlog-do-db=testdb   #记录日志的数据库：需要的备份数据，多个写多行  

binlog-ignore-db=mysql #不记录日志的数据库：不需要备份的数据库，多个写多行  
binlog-ignore-db=sys  
binlog-ignore-db=performance_schema  
binlog-ignore-db=information_schema  

#自增字段奇数递增  
#auto-increment-increment = 2  #每次递增的步长  
#auto-increment-offset = 1  #初始值  

### 查看 master 状态
show master status\G;  


## slave 配置

### 创建同步数据库 
create database testdb default charset utf8;  

### 配置slave my.cnf  

[client]  
port = 3306  
socket = /usr/local/mysql/logs/mysql.sock  

[mysqld]  
port=3306  
server-id=2  
log-bin=mysql-bin  
replicate-do-db =testdb #只复制某个库，多个写多行  

replicate-ignore-db=mysql #不复制某个库  
replicate-ignore-db=sys  
replicate-ignore-db=performance_schema  
replicate-ignore-db=information_schema  

relay-log=mysqld-relay-bin  # 开启日志中继  
log-slave-updates  # slave将复制事件写进自己的二进制日志  

#自增字段奇数递增  
#auto-increment-increment = 2  #每次递增的步长  
#auto-increment-offset = 2  #初始值  

stop slave;  
CHANGE MASTER TO MASTER_HOST='192.168.1.110',MASTER_PORT=3306, MASTER_USER='backup', MASTER_PASSWORD='123456', MASTER_CONNECT_RETRY=60, MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=100;  
start slave;  

#CHANGE MASTER TO  
#MASTER_HOST='192.168.1.110', //主服务器的IP地址  
#MASTER_PORT=3306, //主服务器的端口  
#MASTER_USER='backup', //同步数据库的用户  
#MASTER_PASSWORD='123456', //同步数据库的密码  
#MASTER_CONNECT_RETRY=60,  // 如果从服务器发现主服务器断掉，重新连接的时间差(秒)  
#MASTER_LOG_FILE='mysql-bin.000001', //主服务器二进制日志的文件名(前面要求记住的 File 参数)  
#MASTER_LOG_POS=100; //日志文件的开始位置(前面要求记住的 Position 参数)  

### 查看 slave 状态
show slave status\G;  
