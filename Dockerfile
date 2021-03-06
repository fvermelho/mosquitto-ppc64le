FROM ppc64le/ubuntu:16.04 
ARG MOSQUITTOVERSION 
ENV MOSQUITTOVERSION 1.4.14 
MAINTAINER Ansgar Schmidt <ansgar.schmidt@gmx.net> 
ENV DEBIAN_FRONTEND noninteractive 

RUN apt-get update     && \
    apt-get upgrade -y && \
    apt-get install -y wget build-essential libwrap0-dev libssl-dev python-distutils-extra \
                       libc-ares-dev uuid-dev

RUN     mkdir -p /usr/local/src

WORKDIR          /usr/local/src
RUN     wget http://mosquitto.org/files/source/mosquitto-$MOSQUITTOVERSION.tar.gz
RUN     tar xvzf ./mosquitto-$MOSQUITTOVERSION.tar.gz
WORKDIR /usr/local/src/mosquitto-$MOSQUITTOVERSION
RUN     make && make install
RUN     adduser --system --disabled-password --disabled-login mosquitto
USER mosquitto 

EXPOSE 1883 

CMD ["/usr/local/sbin/mosquitto"]
