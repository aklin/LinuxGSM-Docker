[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://github.com/GameServerManagers/LinuxGSM/blob/master/LICENSE)

# LinuxGSM Docker

> This project deviates from LinuxGSM in one fundamental way: The parent project envisions using Docker containers much in the same way as one would use the command line, issuing commands to build servers on demand. This project however intends to pre-build the servers we need, and manage them through docker-compose or similar orchestration tool. Original documentation follows

This docker image is under development and not officialy supported.

The developers of LinuxGSM are not currently docker experts. So if there is some interested in becoming a LinuxGSM docker developer please contact us.

A docker container distribution of https://github.com/GameServerManagers/LinuxGSM

Dockerhub https://hub.docker.com/r/gameservermanagers/linuxgsm-docker/

Run Game Servers in Docker, multiplex multiple LinuxGSM deployments easily by taking advantage of Dockers port mapping.

## Installation
This will work both on linux and Docker for Windows. With Docker for Windows, skip the first command and make a folder the normal way. When running the container, Docker for Windows may ask for permission to access the folder. Simply allow this action.

```bash
$ mkdir -p /path/to/lgsm && sudo chown -R 750:750 /path/to/lgsm
$ docker run --name lgsm-docker --restart always --net=host --hostname LGSM -it -v "/path/to/lgsm:/home/lgsm/" lgsm-docker
```
