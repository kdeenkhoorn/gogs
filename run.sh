#!/bin/bash
docker run -d --restart always --name=gogs -p 3000:3000 -p 3022:3022 --network host kdedesign/gogs:latest
