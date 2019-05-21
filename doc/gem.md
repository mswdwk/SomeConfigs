# 1 add source
gem sources -a "https://rubygems.xxx.yyy"

# 2 install XXScaffold, not use /usr/bin
sudo gem install -n /usr/local/bin XXScaffold

# 3 
pod install 

# 4 , 第三步如果有报错的话
# for example: Unable to find a specification for `xxxRustHTTP (= 0.1.5)
pod repo update

 # 5 再次执行
 pod install 

# 6 在Podfile文件中注释调Calabash 的安装

# 7 下载 相关的 动态库：sdk

