#!/bin/bash
docker run -d --restart always --name=gogs -p 3000:3000 -p 3022:3022 -v /data/docker/gogs:/data kdedesign/gogs:latest
