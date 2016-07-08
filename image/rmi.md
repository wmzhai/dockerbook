## 移除镜像
如果要移除本地的镜像，可以使用 `docker rmi` 命令。注意 `docker rm` 命令是移除容器。
```
$ docker rmi training/sinatra
```

*注意：在删除镜像之前要先用 `docker rm` 删掉依赖于这个镜像的所有容器。*

## 清理镜像

`docker images` 可以列出本地所有的镜像，其中很可能会包含有很多中间状态的未打过标签的镜像，大量占据着磁盘空间。

使用下面的命令可以清理所有未打过标签的本地镜像

```
$ sudo docker rmi $(docker images -q -f "dangling=true")
```
