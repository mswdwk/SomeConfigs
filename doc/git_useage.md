#查看代码差异
（工作区 vs 暂存区）git diff  
（工作区 vs 版本库）git diff head  
（暂存区 vs 版本库）git diff –cached

#查询一段时间内的所有提交者
```git log --since ==2017-09-01 --until=2017-09-28
--format='%aN' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 + $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -; done
```
#[查询某个人在一段时间内的提交](https://www.jianshu.com/p/ee976eb939bb)
```
git log --since=2017-05-21 --until=2017-06-20 --author="author-name" --pretty=tformat: --numstat | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "added lines: %s removed lines : %s total lines: %s\n",add,subs,loc }' 

git log --since=2017-05-21 --until=2017-06-20 --author="wangsijie" --pretty=tformat: --numstat | gawk     '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "added lines: %s removed lines : %s total lines: %s\n",add,subs,loc }'
```
## 显示提交历史对应的文件修改
git whatchanged --stat

#[commit message 和 change log的编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
```
feat：新功能（feature）
fix：修补bug
docs：文档（documentation）
style： 格式（不影响代码运行的变动）
refactor：重构（即不是新增功能，也不是修改bug的代码变动）
test：增加测试
chore：构建过程或辅助工具
```
# [tag的用法](https://blog.zengrong.net/post/1746.html)
## 打 tag 1.x.y 完成后，推tag 1.x.y
```
git tag -a 1.x.y -m "add a tag v.1.x.y"
git push origin tag 1.x.y
```
//打完tags之后，手动出发发版构建任务
## 将本地所有标签一次性提交到git服务器
```git push origin –tags```

##删除tag 1.x.y
```git push origin :refs/for/1.x.y```

##[查询远程heads和tags的命令如下](http://smilejay.com/2013/04/git-sync-tag-and-branch-with-remote/)
```
git ls-remote --heads origin
git ls-remote --tags origin
git ls-remote origin
```

##显示tagA tagB 之间的commit 
```git log --pretty=oneline tagA..tagB```

#[git branch用法](https://blog.zengrong.net/post/1746.html)
```
git branch     # 查询本地存在的branch
git branch -r  # 查询远程的branch
git branch -a  # 查询本地和远程branch
git branch -d -r origin/todo  #删除远程的todo branch
```

## 删除 本地分支，这些分支是在远程分支中已经被删除了的
```
git remote prune origin
git fetch -p 
```
##重命名本地分支,将devel 重新命名为develop
```git branch -m devel develop```
##推送本地分支
```git push origin develop ```

#更新远程分支
```git remote update origin```

git clean -fxd

#git如何同步本地分支与远程origin的分支
问题场景1：
同事A创建了本地分支branchA并push到了远程->同事B在本地拉取(git fetch)了和远程branchA同步的本地分支branchA->同事A开发完成将远程分支branchA删除（远程仓库已经不存在分支branchA）->同事B用git fetch同步远端分支，git branch -r发现本地仍然记录有branchA的远程分支

分析：远端有新增分支，git fetch可以同步到新的分支到本地，但是远端有删除分支，直接"git fetch"是不能将远程已经不存在的branch等在本地删除的

解决方法：
git fetch --prune #这样就可以实现在本地删除远程已经不存在的分支
或者简略：
git fetch -p
git fetch -p origin
git remote prune origin

#参考文章
[Git教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013745374151782eb658c5a5ca454eaa451661275886c6000)

[Git命令参考手册！只有更全没有最全](
https://baijiahao.baidu.com/s?id=1572090267187343&wfr=spider&for=pc)

#git large file manage: git-lfs
install
[macos]brew install git-lfs
