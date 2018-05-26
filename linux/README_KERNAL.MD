# 升级内核
## 导入key
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org  

## 安装 elrepo 的yum源
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm  

## 安装内核
yum --enablerepo=elrepo-kernel install kernel-ml-devel kernel-ml -y  

## 设置系统启动顺序

### 查看系统启动项
cat /boot/grub2/grub.cfg |grep menuentry  

### 设置最新版本内核为默认启动
grub2-set-default 'CentOS Linux (4.16.12-1.el7.elrepo.x86_64) 7 (Core)'  

### 查看默认启动的系统版本
grub2-editenv list  

## 重启查看内核版本
reboot  
uname -sr  
