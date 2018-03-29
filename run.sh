#!/bin/bash
docker run -d --restart always --name=gogs  -p 192.168.2.1:3022:3022 -p 127.0.0.1:3000:3000 -v /data/gogs:/data kdedesign/gogs
