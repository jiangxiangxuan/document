#!/bin/bash  
A=`netstat -tlpn | grep "5432"|wc -l` #判断pg是否活着  
B=`ip a | grep 192.168.1.88 | wc -l` #判断vip浮到哪里  
C=`ps -ef | grep postgres | grep 'startup process' | wc -l` #判断是否是从库处于等待的状态  
D=`ps -ef | grep postgres | grep 'receiver' | wc -l` #判断从库链接主库是否正常  
E=`ps -ef | grep postgres | grep 'sender' | wc -l` #判断主库连接从库是否正常  
if [ $A -eq 0 ];then #如果pg死了，将消息写入日记并且关闭keepalived  
    echo "`date "+%Y-%m-%d--%H:%M:%S"` postgresql stop so vip stop " >> /usr/local/keepalived/check_pg.log  
    pkill keepalived  
else  
    if [ $B -eq 1 -a $C -eq 1 -a $D -eq 0 ];then #判断出主挂了，vip浮到了从，提升从的地位让他可读写  
        su - postgres -c "pg_ctl promote -D /usr/local/pgsql/data"   
        echo "`date "+%Y-%m-%d--%H:%M:%S"` standby promote " >> /usr/local/keepalived/check_pg.log  
    fi  
    if [ $B -eq 1 -a $C -eq 0 -a $D -eq 0 -a $E -eq 0 ];then #判断出自己是主并且和从失去联系  
        sleep 10  
        echo "`date "+%Y-%m-%d--%H:%M:%S"` can't find standby " >> /usr/local/keepalived/check_pg.log  
    fi  
fi
