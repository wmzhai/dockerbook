## 指令

Dockerfile支持支持的语法命令如下：
```
INSTRUCTION argument
```
指令不区分大小写，但是，命名约定为全部大写。


### FROM

所有Dockerfile都必须以FROM命令开始，FROM命令指定镜像基于哪个基础镜像创建。

Dockerfile第一条指令必须为 `FROM` 指令。并且，如果在同一个Dockerfile中创建多个镜像时，可以使用多个 `FROM` 指令（每个镜像一次）。

格式如下：
```
FROM <image>:<tag>
```
例如
```
FROM ubuntu
```


### MAINTAINER

设置该镜像的作者。

格式如下：
```
MAINTAINER <author name>
```


### RUN

在shell或者exec的环境下执行的命令，就和在shell里面执行的一样。
RUN指令会在新创建的镜像上添加新的层面，接下来提交的结果用在Dockerfile的下一条指令中。

格式如下：
```
RUN <command>
```
或
```
`RUN ["executable", "param1", "param2"]`
```

前者将在 shell 终端中运行命令，即 `/bin/sh -c`；后者则使用 `exec` 执行。指定使用其它终端可以通过第二种方式实现，例如 `RUN ["/bin/bash", "-c", "echo hello"]`。

每条 `RUN` 指令将在当前镜像基础上执行指定命令，并提交为新的镜像。当命令较长时可以使用 `\` 来换行。


每个run指令都是在image的top writable layer执行一个commit，所以最好使用 `&&` 把连续的指令连接起来，比如

```
RUN apt-get update && apt-get install -y curl vim openjdk-7-jdk
```

### ADD

复制文件指令。它有两个参数<source>和<destination>。
destination是容器内的路径。source可以是URL或者是启动配置上下文中的一个文件。

格式如下
```
ADD <src> <dest>
```

该命令将复制指定的 `<src>` 到容器中的 `<dest>`。
其中 `<src>` 可以是Dockerfile所在目录的一个相对路径；也可以是一个 URL；还可以是一个 tar 文件（自动解压为目录）。

### COPY
复制本地主机的 `<src>`（为 Dockerfile 所在目录的相对路径）到容器中的 `<dest>`。

当使用本地目录为源目录时，推荐使用 `COPY`。

格式如下
```
COPY <src> <dest>
```

### CMD

容器在创建后默认的执行命令。在image被build的过程中，这个指令不起作用。
Dockerfile只允许使用一次CMD指令，使用多个CMD会抵消之前所有的指令，只有最后一个指令生效。

CMD指定的命令可以被docker run传递的命令覆盖。
如果用户启动容器时候指定了运行的命令，则会覆盖掉 `CMD` 指定的命令。

格式如下：

* `CMD ["executable","param1","param2"]` 使用 `exec` 执行，推荐方式；
* `CMD command param1 param2` 在 `/bin/sh` 中执行，提供给需要交互的应用；
* `CMD ["param1","param2"]` 提供给 `ENTRYPOINT` 的默认参数；

### ENTRYPOINT

配置给容器一个可执行的命令，每次使用镜像创建容器时一个特定的应用程序可以被设置为默认程序。
该镜像每次被调用时仅能运行指定的应用。
类似于CMD，Docker只允许一个ENTRYPOINT，多个ENTRYPOINT会抵消之前所有的指令，只执行最后的ENTRYPOINT指令。

配置容器启动后执行的命令，并且不可被 `docker run` 提供的参数覆盖。
ENTRYPOINT会把容器名后面的所有内容都当成参数传递给其指定的命令（不会对命令覆盖）


格式如下：
* `ENTRYPOINT ["executable", "param1", "param2"]`
* `ENTRYPOINT command param1 param2`（shell中执行）。


### EXPOSE
指定容器在运行时监听的端口，供互联系统使用。在启动容器时需要通过 -P，Docker 主机会自动分配一个端口转发到指定的端口。

格式如下：
```
EXPOSE <port> [<port>...]
```

### ENV
设置环境变量。它们使用键值对，增加运行程序的灵活性。

格式为 `ENV <key> <value>`。
指定一个环境变量，会被后续 `RUN` 指令使用，并在容器运行时保持。

例如
```
ENV PG_MAJOR 9.3
ENV PG_VERSION 9.3.4
RUN curl -SL http://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgress && …
ENV PATH /usr/local/postgres-$PG_MAJOR/bin:$PATH
```

### VOLUME
格式为 `VOLUME ["/data"]`。

创建一个可以从本地主机或其他容器挂载的挂载点，一般用来存放数据库和需要保持的数据等。

### USER
格式为 `USER daemon`。

指定运行容器时的用户名或 UID，后续的 `RUN` 也会使用指定用户。

当服务不需要管理员权限时，可以通过该命令指定运行用户。并且可以在之前创建所需要的用户，例如：`RUN groupadd -r postgres && useradd -r -g postgres postgres`。要临时获取管理员权限可以使用 `gosu`，而不推荐 `sudo`。

### WORKDIR

指定RUN、CMD与ENTRYPOINT命令的工作目录。



格式为 `WORKDIR /path/to/workdir`。

可以使用多个 `WORKDIR` 指令，后续命令如果参数是相对路径，则会基于之前命令指定的路径。例如
```
WORKDIR /a
WORKDIR b
WORKDIR c
RUN pwd
```
则最终路径为 `/a/b/c`。

### ONBUILD
格式为 `ONBUILD [INSTRUCTION]`。

配置当所创建的镜像作为其它新创建镜像的基础镜像时，所执行的操作指令。

例如，Dockerfile 使用如下的内容创建了镜像 `image-A`。
```
[...]
ONBUILD ADD . /app/src
ONBUILD RUN /usr/local/bin/python-build --dir /app/src
[...]
```

如果基于 image-A 创建新的镜像时，新的Dockerfile中使用 `FROM image-A`指定基础镜像时，会自动执行 `ONBUILD` 指令内容，等价于在后面添加了两条指令。
```
FROM image-A

#Automatically run the following
ADD . /app/src
RUN /usr/local/bin/python-build --dir /app/src
```

使用 `ONBUILD` 指令的镜像，推荐在标签中注明，例如 `ruby:1.9-onbuild`。
