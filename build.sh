#!/bin/bash

GOGSVER=0.11.86
GOVER=1.12.1

cd ./build-context
docker build --network host --build-arg GOGSVER=${GOGSVER} --build-arg GOVER=${GOVER} -t kdedesign/gogs:${GOGSVER} .
docker tag kdedesign/gogs:${GOGSVER} kdedesign/gogs:latest
