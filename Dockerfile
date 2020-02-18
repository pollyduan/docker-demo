FROM ubuntu:18.04
MAINTAINER pollyduan@163.com

RUN echo echo docker demo version 1.0 > /version.sh
RUN echo echo https://github.com/pollyduan/docker-demo/blob/master/how-to.md >> /version.sh

CMD ["bash","/version.sh"]
