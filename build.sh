#!/bin/bash

GOGSVER=0.12.4
GOVER=1.17.6

cd ./build-context
docker build --network host --build-arg GOGSVER=${GOGSVER} --build-arg GOVER=${GOVER} -t kdedesign/gogs:${GOGSVER} .
docker tag kdedesign/gogs:${GOGSVER} kdedesign/gogs:latest
