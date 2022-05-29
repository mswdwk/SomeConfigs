#curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# make sure you can resolve raw.github.com by DNS, or ,you should add the right ip in 
# file /etc/hosts
# you can debug curl by 'curl --trace t.log   www.xxx.zzz.url'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
