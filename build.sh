#!/bin/bash

GOGSVER=0.13.0
GOVER=1.20.2

cd ./build-context
docker build --network host --build-arg GOGSVER=${GOGSVER} --build-arg GOVER=${GOVER} -t kdedesign/gogs:${GOGSVER} .
docker tag kdedesign/gogs:${GOGSVER} kdedesign/gogs:latest
