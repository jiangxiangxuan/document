# 安装redis
tar -xzvf redis-4.0.1.tar.gz
cd redis-4.0.1
make
make PREFIX=/usr/local/redis install
cp  redis-4.0.1/redis.conf   /usr/local/redis/bin

## redis配置文件
vim /usr/local/redis/bin/redis.conf
daemonize yes 		#以后端模式启动
requirepass 123456  #密码
