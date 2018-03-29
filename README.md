# GOGS
This docker image is an armhf version of GOGS based on my own debian 9 linux image.

## Image dependencies:
- One volume /data required for persistent storage
- Port 3000 for HTTP access to the GOGS daemon.
- Port 3022 for SSH access to the GOGS daemon.
- User: git (uid: 3000)
- Group: git (gid: 3000)

## Typical run command:
- $ docker run -d --restart always --name=gogs  -p 3022:3022 -p 3000:3000 -v /data/gogs/data:/data kdedesign/gogs
or:
- $ docker run -d --restart always --name=gogs  -p 3022:3022 -p 3000:3000 -v /data/gogs/ssh:/opt/gogs
/.ssh -v /data/gogs/data:/data kdedesign/gogs
If you want to save your generated ssh key.


## Build characteristics:
- Debian 9 (kdedesign/debian-stretch:1.0)
- Go 1.10 (go1.10.linux-armv6l.tar.gz)
- GOGS 0.11.34 (v0.11.34.tar.gz)

## GOGS build command:
- go build -tags "sqlite cert"

## More info:
- Check https://github.com/kdeenkhoorn/gogs

Have fun!

Kl@@s
