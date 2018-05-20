# 安装postgresql

## 编译安装
yum install -y perl-ExtUtils-Embed  
yum install -y perl-ExtUtils-Embed  
yum install -y systemtap-sdt-devel.x86_64  
yum install -y readline readline-devel  
yum install -y openssl openssl-devel  
yum install -y pam pam-devel  
yum install -y libxslt libxslt-devel  
yum install -y tcl tcl-devel  
yum install -y openldap openldap-devel  
yum install -y python python-devel  

tar -zxvf postgresql-10.1.tar.gz  
cd postgresql-10.1  
./configure --prefix=/usr/local/pgsql --with-perl --with-tcl --with-python --with-openssl --with-pam --without-ldap --with-libxml --with-libxslt --enable-thread-safety --with-wal-blocksize=16 --with-blocksize=16 --enable-dtrace --enable-debug  
make  
make install  

## postgresql配置环境变量
vim /etc/profile  
export PGHOME=/usr/local/pgsql  	#(这个就是我们的安装目录)  
export PGDATA=$PGHOME/data        	#(数据存放的目录)  
export PATH=$PATH:$HOME/bin:$PGHOME/bin  
source /etc/profile  

## postgresql相关命令
adduser postgres  
mkdir /usr/local/pgsql/data  
chown -R postgres:postgres /usr/local/pgsql/data  
su - postgres  

initdb -D /usr/local/pgsql/data  
pg_ctl stop -D /usr/local/pgsql/data  
pg_ctl start -D /usr/local/pgsql/data  
pg_ctl restart -D /usr/local/pgsql/data  
pg_ctl reload -D /usr/local/pgsql/data  
pg_ctl start -D /var/pg_data/data/  
vacuumdb -d platform_db -f -z -v  #清理数据库  
vacuumdb --analyze --verbose --table 'tb_test' db_test #单独每个表进行vacuum  

## postgresql配置
### 修改用户密码
    su - postgres  切换用户，执行后提示符会变为 '-bash-4.2$'  
    psql -U postgres 登录数据库，执行后提示符变为 'postgres=#'  
    ALTER USER postgres WITH PASSWORD '123456';  设置postgres用户密码  
    \q  退出数据库  
### 开启远程访问
    vi /usr/local/pgsql/data/postgresql.conf  
    修改#listen_addresses = 'localhost'  为  listen_addresses='*'  
    当然，此处‘*’也可以改为任何你想开放的服务器IP  
### 信任远程连接
    vi /usr/local/pgsql/data/pg_hba.conf  
    修改如下内容，信任指定服务器连接  
    # IPv4 local connections:  
    host    all            all      127.0.0.1/32      trust  
	host    all            all      0.0.0.0/0         md5  

## PostgreSQL支持100万个连接
SEMMNS >= ((max_connections + max_worker_processes + autovacuum_max_workers + 5) / 16) * 17  

export USE_UNNAMED_POSIX_SEMAPHORES=1  
LIBS=-lpthread ./configure  --prefix=/usr/local/pgsql  
make world -j 32  
make install-world -j 32  

vi postgresql.conf  
max_connections = 1000000  
constraint_exclusion = on  
enable_nestloop = off  

tcp_keepalives_idle = 180  
tcp_keepalives_interval = 30  
tcp_keepalives_count = 3  
pg_ctl restart -m fast  

sysctl -w kernel.pid_max=4096000  

net.ipv4.tcp_keepalive_time = 600  
net.ipv4.tcp_keepalive_probes = 3  
net.ipv4.tcp_keepalive_intvl = 15  
