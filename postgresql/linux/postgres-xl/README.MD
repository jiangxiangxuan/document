# 安装postgres-xl (待完善)
192.168.1.100 (gtm)  
192.168.1.110 (coordinator,datanode)  
192.168.1.111 (coordinator,datanode) 

http://www.cnblogs.com/lottu/p/5646486.html
https://www.cnblogs.com/jiangxu/archive/2012/11/12/2766745.html

## 编译安装
下载postgres-xl: wget https://www.postgres-xl.org/downloads/postgres-xl-10alpha2.tar.bz2
bzip2 -d postgres-xl-10alpha2.tar.bz2
tar -xvf postgres-xl-10alpha2.tar
cd postgres-xl-10alpha2
./configure --prefix=/usr/local/postgres-xl
make -j4
make install

cd contrib
make -j4
make install

## 环境变量
export PGUSER=postgres
export PGHOME=/usr/local/postgres-xl:$PGHOME
export LD_LIBRARY_PATH=$PGHOME/lib:$LD_LIBRARY_PATH
export PATH=$HOME/bin:$PGHOME/bin:$PATH

## 配置ssh免密码登录for pgxc_ctl
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
scp ~/.ssh/authorized_keys postgres@192.168.1.110:~/.ssh/
scp ~/.ssh/authorized_keys postgres@192.168.1.111:~/.ssh/
若其他服务器没有.ssh目录；可手动创建下 mkdir .ssh;chmod 700 .ssh

## 配置集群并使用pgxc_ctl初始化集群
在gtm节点服务器操作；新建192.168.1.100服务器的/usr/local/postgres-xl/pgxc_ctl.conf文件；添加如下内容
	#user and path 
	pgxcOwner=postgres
	pgxcUser=$pgxcOwner
	pgxcInstallDir=/usr/local/postgres-xl

	#gtm and gtmproxy
	gtmMasterDir=/usr/local/postgres-xl/nodes/gtm
	gtmMasterPort=6666
	gtmMasterServer=192.168.1.100
	gtmSlave=n

	#gtm proxy
	gtmProxy=n

	#coordinator
	coordMasterDir=/usr/local/postgres-xl/nodes/coord
	coordNames=(coord1 coord2)
	coordPorts=(5432 5432)
	poolerPorts=(6667 6668)
	coordPgHbaEntries=(192.168.1.0/32)
	coordMasterServers=(192.168.1.110 192.168.1.111)
	coordMasterDirs=($coordMasterDir/coord1 $coordMasterDir/coord2)
	coordMaxWALsernder=0
	coordMaxWALSenders=($coordMaxWALsernder $coordMaxWALsernder)
	coordSlave=n
	coordSpecificExtraConfig=(none none none)
	coordSpecificExtraPgHba=(none none none)

	#datanode
	datanodeNames=(datanode1 datanode2)
	datanodePorts=(15432 15432)
	datanodePoolerPorts=(6669 6670)
	datanodePgHbaEntries=(192.168.1.0/32)
	datanodeMasterServers=(192.168.1.110 192.168.1.111)
	datanodeMasterDir=/usr/local/postgres-xl/nodes/datanode
	datanodeMasterDirs=($datanodeMasterDir/datanode1 $datanodeMasterDir/datanode2)
	datanodeMaxWalSender=0
	datanodeMaxWALSenders=($datanodeMaxWalSender $datanodeMaxWalSender)
	datanodeSlave=n
	primaryDatanode=datanode1

## 初始化集群
pgxc_ctl -c /usr/local/postgres-xl/pgxc_ctl.conf init all 
## 启动/关闭集群
pgxc_ctl -c /usr/local/postgres-xl/pgxc_ctl.conf start all 
pgxc_ctl -c /usr/local/postgres-xl/pgxc_ctl.conf stop all 
