#!/bin/bash
docker run -d --restart always --name=gogs  -p 192.168.2.1:3022:3022 -p 127.0.0.1:3000:3000 -v /data/gogs/ssh:/opt/gogs/.ssh -v /data/gogs/data:/data kdedesign/gogs
