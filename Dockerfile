FROM ubuntu:18.04
MAINTAINER pollyduan@163.com

RUN echo echo docker demo version 1.0 > /version.sh

CMD ["bash","-c","/version.sh"]
