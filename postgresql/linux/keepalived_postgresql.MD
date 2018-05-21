# keepalived+postgresql 主从配置
	主ip:192.168.1.110
	从ip:192.168.1.111


# 主库配置

## 主库创建一个数据库角色，赋予登陆和复制的权限
	CREATE ROLE replica login replication encrypted password '123456';
	\du   #列出所有用户
## 主库配置文件修改
	vim postgresql.conf
	listen_addresses = '*'   # 监听所有IP  
	port = 5432              
	max_connections = 100  #这个设置要注意下，从库的max_connections必须要大于主库的  
	wal_level = hot_standby   
	max_wal_senders = 32 # 这个设置了可以最多有几个流复制连接，差不多有几个从，就设置几个  
	wal_keep_segments = 256 # 设置流复制保留的最多的xlog数目  
	wal_sender_timeout = 60s # 设置流复制主机发送数据的超时时间  
	
	允许测试服务器和从服务器来访问
	vim pg_hba.conf
	host    replication     replica         192.168.1.111/32           md5

## 主库重启
	pg_ctl stop -D $PGDATA  
	pg_ctl start -D $PGDATA -l logfile  


# 从库配置

## 从库同步主库数据
	rm -rf ./*   #先将data目录下的数据都清空  
	pg_basebackup -F p --progress -D  $PGDATA -h 192.168.1.110 -p 5432 -U replica --password  # 基础备份  
	输入密码:123456
## 从库修改recovery.conf
	cp ../share/recovery.conf.sample recovery.conf
	vim recovery.conf
	standby_mode = on  
	primary_conninfo = 'host=192.168.1.110 port=5432 user=replica password=123456'  
	recovery_target_timeline = 'latest'
## 从库修改postgres.conf
	vim postgres.conf  
	max_connections = 1000  
	hot_standby = on  
	max_standby_streaming_delay = 30  
	wal_receiver_status_interval = 1s  
	hot_standby_feedback = on  
	
## 从库重启
	pg_ctl stop -D $PGDATA  
	pg_ctl start -D $PGDATA -l logfile  


# keepalived
## keepalived安装
	见keepalived安装
## keepalived配置	
	见keepalived_postgresql_config目录
