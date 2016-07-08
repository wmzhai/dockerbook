## 获取镜像

可以使用 `docker pull` 命令来从仓库获取所需要的镜像。

下面的例子将从 Docker Hub 仓库下载一个 Ubuntu 16.04 操作系统的镜像。
```
$ docker pull ubuntu:16.04
```

下载过程中，会输出获取镜像的每一层信息。该命令实际上相当于
```
$ docker pull registry.hub.docker.com/ubuntu:16.04
```

即从注册服务器 `registry.hub.docker.com` 中的 `ubuntu` 仓库来下载标记为 `16.04` 的镜像。


从其它仓库下载时需要指定完整的仓库注册服务器地址。例如
```
$ docker pull daocloud.io/ubuntu:16.04
```
