# GOGS
This docker image is an armhf version of GOGS based on my own debian 9 linux image.

## Image dependencies:
- One volume /data required for persistent storage
- Port 3000 for HTTP access to the GOGS daemon.
- Port 3022 for SSH access to the GOGS daemon.
- User: git (uid: 3000)
- Group: git (gid: 3000)


## Build characteristics:
- Debian 9 (kdedesign/debian-stretch:1.0)
- Go 1.10 (go1.10.linux-armv6l.tar.gz)
- GOGS 0.11.34 (v0.11.34.tar.gz)

## GOGS build command:
- go build -tags "sqlite cert"

## Typical run command:
```
$ docker run -d --restart always --name=gogs  -p 3022:3022 -p 3000:3000 -v /data/gogs/data:/data kdedesign/gogs
```

## Handy commands:
### Making a backup of gogs, repositories and database
Making a backup of your gogs instance is easy even though it is running in a docker container. All you need is the name of the container to connect to, in the example above the name is 'gogs' (--name=gogs). So start your backup this way:

```
$ docker exec -it docker exec -it gogs /opt/gogs/gogs backup --target=/data/backup --config=/data/app.ini 
```
Using the command above your backup will be placed in the directory '/data/backup'.
Want to know more or how to restore, please read the article: https://discuss.gogs.io/t/how-to-backup-restore-and-migrate/991


### Saving SSH keys
If you wish to use a githook, for example to mirror your local gogs repository on GutHub you can make use of a ssh public/private key. These keys typically are placed in the .ssh directory in the home directory of the user.
To place these files you can make a persistent storige of the .ssh directory like this:
```
$ docker run -d --restart always --name=gogs  -p 3022:3022 -p 3000:3000 -v /data/gogs/ssh:/opt/gogs
/.ssh -v /data/gogs/data:/data kdedesign/gogs
```
Now you can connect to the container and execute as the user git the command:
```
$ docker exec -it gogs bash
```
and run inside the container:
```
$ ssh-keygen -t rsa -b 4069
```
Now copy the contents of the id_rsa.pub file to github.
Before starting the githook for the first time you have to copy the key from github to your known_hosts file.
To do this you can execute:
```
$ ssh github.com
```
The command will fail, it wil not connect but before it fails it asks you to store the key from GitHub in your known_hosts file, and this is what we want in the end.
You can also run the 'post-receive' hook script from inside your repository.

Finally now you can define a githook in gogs for your repository, for example a 'post-receive' hook to mirror your repository to GitHub. Enter the following code to achieve this:
```
#!/bin/bash
git push --mirror git@github.com:kdeenkhoorn/gogs.git
```
If all went wel you will see the magic happen!

## More info:
- Check https://github.com/kdeenkhoorn/gogs

Have fun!

Kl@@s
