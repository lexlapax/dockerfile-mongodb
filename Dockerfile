# MongoDB
# =======
#
# Build:
#
#   docker build -t lapax/mongodb .
#
# Run:
#
#   docker run -d -p 27017:27017 -p 28017:28017 -v /path/to/data/:/data lapax/mongodb
#
# VERSION   0.1
# based on https://github.com/waitingkuo/dockerfiles/blob/master/dockerfiles/mongodb/Dockerfile


FROM ubuntu:latest
MAINTAINER lexlapax@gmail

# Hack for initctl no being available in Ubuntu
# https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee /etc/apt/sources.list.d/10gen.list
RUN apt-get update
RUN apt-get install -y mongodb-10gen

# DIR For MongoDB
RUN mkdir -p /data/db
RUN mkdir -p /data/etc

# mongod
EXPOSE 27017

# web console
EXPOSE 28017


CMD ["mongod", "-f", "/data/etc/mongodb.conf"]