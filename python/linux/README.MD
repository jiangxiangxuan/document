# 安装python

## 安装yaml
tar -xzvf yaml-0.1.7.tar.gz  
cd yaml-0.1.7  
./configure  
make  
make install  

## 安装Python-2.7.14 
tar -xzf Python-2.7.14.tgz  
cd Python-2.7.14  
./configure --with-zlib  
make  
make install  

## 安装distribute
unzip distribute-0.7.3.zip  
cd distribute-0.7.3/  
python setup.py install  

## 安装Cheetah
tar -xzvf Cheetah3-3.1.0.tar.gz  
cd Cheetah3-3.1.0  
python setup.py build  
python setup.py install  

## 安装typing
tar -xzvf typing-3.6.4.tar.gz  
cd typing-3.6.4  
python setup.py build  
python setup.py install  


## 安装PyYAML
tar -xzvf PyYAML-3.12.tar.gz  
cd PyYAML-3.12  
python setup.py build  
python setup.py install  
