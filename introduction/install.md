## 安装Docker

### Linux通用安装

在Ubuntu和CentOS上可以执行如下指令快速安装

```
curl -fsSL https://get.docker.com/ | sh
```

如果需要非root用户使用docker指令而不加sudo，可以执行如下指令将用户添加到docker组里

```
sudo usermod -aG docker username
```

### 清华镜像安装

Ubuntu 1604如下，其余可以参考[安装说明](https://mirrors.tuna.tsinghua.edu.cn/help/docker/)

首先信任 Docker 的 GPG 公钥:
```
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

然后添加源
```
echo "deb https://mirrors.tuna.tsinghua.edu.cn/docker/apt/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
```

最后安装
```
sudo apt-get update
sudo apt-get install docker-engine
```

### MacOS

可以下载安装包安装

https://www.docker.com/products/docker#/mac

### Windows

要求Window 10 64bit，可以下载安装包安装

https://www.docker.com/products/docker#/windows
