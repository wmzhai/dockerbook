# Docker —— 从入门到实践

[Docker](http://www.docker.com) 是个很有意思的开源项目，它彻底释放了虚拟化的威力，极大提高了应用的运行效率，降低了云计算资源供应的成本，同时让应用的部署、测试和分发都变得前所未有的高效和轻松！

无论是应用开发者，运维人员，还是云计算从业人员，都有必要认识和掌握 Docker，以在有限的时间内做更多有意义的事。

本书既适用于具备基础 Linux 知识的 Docker 初学者，也希望可供理解原理和实现的高级用户参考。同时，书中给出的实践案例，可供在进行实际部署时借鉴。前六章为基础内容，供用户理解 Docker 的基本概念和操作；7 ~ 9 章介绍一些高级操作；第 10 章给出典型的应用场景和实践案例；11 ~ 13 章介绍关于 Docker 实现的相关细节技术。后续章节则分别介绍一些相关的热门开源项目。

## 安装gitbook

```
npm install gitbook-cli -g
```

## 预览书籍

使用下列命令会运行一个服务器, 通过 http://localhost:4000/ 可以预览书籍
```
gitbook serve
```

运行该命令后会在书籍的文件夹中生成一个 `_book` 文件夹, 里面的内容即为生成的 html 文件.

## 生成书籍

我们可以使用下面命令来生成网页而不开启服务器

```
gitbook build
```


## 快速操作


### 基本信息

* 查看info: `docker info`
* docker --help 整体的帮助，显示所有指令
* docker command --help 针对特定指令的帮助文档

### docker run 创建容器

* -d: 后台运行容器
* -P: 直接将容器内部的端口映射出去
* -p 80:5000 将容器的5000端口映射成localhost的80端口
* --name 为容器命名
* -v 添加data volume: 比如 `docker run -d -P --name web -v /webapp training/webapp python app.py`
* -v host-dir:container-dir
  * 比如 ` docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py`  将host的`/src/webapp` 加载到容器的`/opt/webapp`上
  * MacOS上Docker只有权限共享/Users 目录，所以只能这样写 `docker run -v /Users/<path>:/<container path> ...`
  * Windows上 只有权限共享 `C:\Users`目录，所以只能这样写 `docker run -v /c/Users/<path>:/<container path> ...`
* -link 通过名称来进行2个容器的通信，不适用ip和端口，举例如下
```
  docker run -d --name database postgres
  docker run -d -P --name website --link database:db ngnix
```
最终实际上会在website的/etc/hosts里面创建一个指向db的快捷方式

举例：
- 交互式启动一个cotainer: `docker run -i -t ImageName`
- 交互式启动一个自定义命名的cotainer: `docker run --name ContianerName -i -t ImageName`
- 守护式启动一个cotainer: `docker run -d ImageName`
- 守护式启动一个自定义命名的cotainer: `docker run --name ContianerName -d ImageName`


### 查看容器
- docker ps -l: 最后一个启动的容器
- docker ps -a: 所有容器，包括不在运行的
- 查看容器中的进程: `docker top ContianerName/ContainerId`
- 查看容器中的log: `docker logs ContianerName/ContainerId`
- 查看容器中的log(follow模式): `docker logs -f ContianerName/ContainerID`
- docker inspect

### 容器的启动、停止与删除
- 重新启动一个已有的cotainer: `docker start ContianerName/ContainerId`
- 停止一个已运行的cotainer: `docker stop ContianerName/ContainerId`
- 删除一个cotainer: `docker rm ContianerName/ContainerId`
- 删除Docker中全部cotainer: docker rm `docker ps -a -q`

### 通过docker进行container内部操作
- 深入查看container的info: `docker info`
- 守护式操作容器: `docker exec -d ContianerName/ContainerId CommandText`
- 交互式操作容器: `docker exec -i -t ContianerName/ContainerId CommandText`

使用exec指令在容器里面启动一个新的进程，执行/bin/bash可以获得一个shell，比如
`docker exec -i -t [ContainerId] /bin`

### 通过docker进行image的操作
- 在客户端登陆Docker Hub: `docker login`
- 查看image列表: `docker images`
- 拉取image列表: `docker pull ImageName`
- 拉取特定的image: `docker pull ImageName:TagName`
- 搜索image: `docker search ImageName`
- commit image: `docker commit -m"llllllll" --author="XXXXX" ContainerID Username/ImageName`(官方不推荐)
- build image: `docker build -t TagName ContextPath`
- 查看image历史: `docker build history ImageID`
