# 安装valgrind
bzip2 -d valgrind-3.13.0.tar.bz2  
tar -xvf valgrind-3.13.0.tar  
cd valgrind-3.13.0  
./configure  
make  
make install  

## 命令
valgrind -v --log-file=valgrind.log --tool=memcheck --leak-check=full --show-mismatched-frees=yes ./main  
