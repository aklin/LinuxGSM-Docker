#
# LinuxGSM Dockerfile
#
# https://github.com/GameServerManagers/LinuxGSM-Docker
#

FROM debian:stable-slim
LABEL maintainer="www.arma3.gr"

ENV DEBIAN_FRONTEND noninteractive
ENV HOMEVOL /home/lgsm

ARG STEAM-USER
ARG STEAM-PASS

ADD lgsm-dependencies.list .

## Base System
RUN dpkg --add-architecture i386 && \
	apt-get update -y && \
	apt-get install -y $(cat lgsm-dependencies.list) && \
	apt-get autoremove --purge && \
	rm lgsm-dependencies.list

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
WORKDIR ${HOMEVOL}
VOLUME [ "${HOMEVOL}" ]

# Save Steam credentials for later consumption
RUN touch lgsmsecrets && \
	echo "steamuser=\"${STEAM-USER}\"" > ${HOMEVOL}/lgsmsecrets && \
	echo "steampass=\"${STEAM-PASS}\"" >> ${HOMEVOL}/lgsmsecrets

# need use xterm for LinuxGSM
ENV TERM=xterm

## Docker Details
ENV PATH=$PATH:/home/lgsm
