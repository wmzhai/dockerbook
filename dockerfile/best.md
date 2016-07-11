## 最佳实践


### 在Dockerfile起始处使用同样的指令以利用缓存

每个dockerfile的指令在image做出一些修改，并作为后继指令的基础。 如果image具有相同的parent和指令，则会复用缓存里的image。

为了有效利用缓存，需要保持Dockerfile前面一致，仅修改后面部分。比如所有的Dockerfile保留如下前缀，一旦MAINTAINER这样的小改变发生也会迫使docker运行RUN来更新apt，而不是使用缓存。

```
FROM ubuntu
MAINTAINER Michael Crosby <michael@crosbymichael.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
```

###  当构建镜像时使用可理解的标签，以便更好地管理镜像

除非是实验性的build，一般都需要传递-t参数来构建带tag的镜像。一个简单的可读tag会帮助你管理每个创建的镜像。

```
docker build -t="crosbymichael/sentry" .
```

###  避免在Dockerfile中映射公有端口

docker的两个重要概念是复用性和可移植性，镜像应该可以在任何主机上运行任何次数。
使用Dockerfile你可以映射私有和公共端口，不过你不应该在Dockerfile里面来映射，否则你只能有一个运行实例。
正常实在运行image时通过-p参数来指定容器的端口。

```
# private and public mapping
EXPOSE 80:8080

# private only
EXPOSE 80
```

###  CMD与ENTRYPOINT命令请使用数组语法


###  ENTRYPOINT和CMD最好放在一起使用
