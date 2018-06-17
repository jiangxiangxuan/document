# 安装vim
yum install -y vim  

## 安装ctags
tar -xzvf ctags-5.8.tar.gz  
cd ctags-5.8  
./configure  
make  
make install  

### 生成项目ctags文件
ctags -R .  

## 安装nerdtree
unzip nerdtree.zip  
mkdir -p ~/.vim/{plugin,doc}  
cp plugin/NERD_tree.vim ~/.vim/plugin/  
cp doc/NERD_tree.txt ~/.vim/doc/  

## vim配置
vim ~/.vimrc  
" NERDTree  
map \<F10\> :NERDTreeToggle\<CR\>  
set tags=tags;/  
set ts=4  
set nu  
