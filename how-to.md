在docker官方仓库自动构建镜像
===

[toc]

### 注册登录官方仓库

https://hub.docker.com/

### 创建github项目

`pollyduan/docker-demo`

https://github.com/pollyduan/docker-demo

添加 Dockerfile，内容如下：

```Dockerfile
FROM ubuntu:18.04
MAINTAINER pollyduan@163.com
```

### 创建进行仓库

点击按钮 `Create Repository`，选择自己的用户名（一般只有一个），在后面Name 输入框中输入仓库名，如：`docker-demo`

在 `Description` 文本框中输入简短描述，可选。

```
a automated image demo, Dockerfile in github.
```

在 `Build Settings` 中选择 `Connected`，在github仓库配置项中选择前面创建的项目： `pollyduan/docker-demo`

点击 `Build Rules` 后面的 `+` 图标，显示了自动的对应 `master` 分支的 `latest` 规则，不要改动。

继续添加规则，点击 `Build Rules` 后面的 `+` 图标，输入如下规则：

```
Source Type: Tag
Source: /^[0-9.]+$/
Docker Tag: {sourceref}
```

点击 `Create` 按钮，完成。

也可以点击 `Save And Build` 完成第一次构建。

### 第一次自动构建

修改Dockerfile，并推送到github。

```
FROM ubuntu:18.04
MAINTAINER pollyduan@163.com

RUN echo echo docker demo version 1.0 > /version.sh

CMD ["bash","-c","/version.sh"]
```

等待几分钟，也可以去docker仓库中查看是否自动构建完成。

https://hub.docker.com/repository/docker/pollyduan/docker-demo

```
Last pushed: a minute ago
```

测试：

```
docker pull pollyduan/docker-demo
docker run -ti --rm pollyduan/docker-demo bash /version.sh
```

可以看到显示了最近更新的内容：

```
docker demo version 1.0
```

### 构建带标签的镜像

首先确认指定标签的镜像并不存在：

```
# docker pull pollyduan/docker-demo:1.0
Error response from daemon: manifest for pollyduan/docker-demo:1.0 not found: manifest unknown: manifest unknown
```

github代码不需要修改，只需要为当前github中的项目版本打标签：

```
git tag 1.0
git push --tags
```

刷新docker仓库，确认构建生效了。或者耐心等待几分钟。

```
https://hub.docker.com/repository/docker/pollyduan/docker-demo
```

测试，这次不需要预先拉取镜像了，直接执行：

```
docker run -ti --rm pollyduan/docker-demo:1.0 bash /version.sh
```

### 更新仓库的文档

在github仓库中增加文本文件：`README.md`，内容如下：

```
docker-demo
===

这是一个将github中的Dockerfile在docker官方仓库自动构建的例子。
```

推送到github即可。

