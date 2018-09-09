#!/bin/bash

## simple building script to create the image/container
VERSION=0.0.1
REPO=lgsm
NAME=base

sudo docker build -t ${REPO}/${NAME}:latest -t ${REPO}/${NAME}:${VERSION} .
