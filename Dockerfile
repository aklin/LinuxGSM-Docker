#
# LinuxGSM Dockerfile
#
# https://github.com/GameServerManagers/LinuxGSM-Docker
#

FROM debian:stable-slim
LABEL maintainer="LinuxGSM <me@Danielgibbs.co.uk>"

ENV DEBIAN_FRONTEND noninteractive
ADD lgsm-dependencies.list /tmp/.

## Base System
RUN dpkg --add-architecture i386
RUN	apt-get update -y
RUN	apt-get install -y $(cat /tmp/lgsm-dependencies.list) 
RUN apt-get autoremove --purge

## lgsm.sh
RUN wget https://linuxgsm.com/dl/linuxgsm.sh

## user config
RUN groupadd -g 750 -o lgsm && \
	adduser --uid 750 --disabled-password --gecos "" --ingroup lgsm lgsm && \
	chown lgsm:lgsm /linuxgsm.sh && \
	chmod +x /linuxgsm.sh && \
	cp /linuxgsm.sh /home/lgsm/linuxgsm.sh && \
	usermod -G tty lgsm && \
	chown -R lgsm:lgsm /home/lgsm/ && \
	chmod 755 /home/lgsm

USER lgsm
WORKDIR /home/lgsm
VOLUME [ "/home/lgsm" ]

# need use xterm for LinuxGSM
ENV TERM=xterm

## Docker Details
ENV PATH=$PATH:/home/lgsm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh" ]
