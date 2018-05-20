# 安装boost
下载boost:wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz  
tar xzf boost_1_67_0.tar.gz  
cd boost_1_67_0  
./bootstrap.sh --with-libraries=system,filesystem,log,thread --with-toolset=gcc  
./b2 toolset=gcc cxxflags="-std=c++11"  
./b2 install --prefix=/usr/local/boost  
