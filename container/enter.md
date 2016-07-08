## 进入容器

在使用 `-d` 参数时，容器启动后会进入后台。

某些时候需要进入容器进行操作，可以使用如下2种方法，推荐第一种。

### 启动新的bash进程

```
docker exec -i -t [ContainerId] /bin/bash
```

### attach 命令
`docker attach` 是Docker自带的命令。下面示例如何使用该命令。
```
$ docker run -idt ubuntu
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
243c32535da7        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           nostalgic_hypatia
$ docker attach nostalgic_hypatia
root@243c32535da7:/#
```
但是使用 `attach` 命令有时候并不方便。当多个窗口同时 attach 到同一个容器的时候，所有窗口都会同步显示。当某个窗口因命令阻塞时,其他窗口也无法执行操作了。
