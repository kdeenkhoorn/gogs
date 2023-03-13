# GOGS
This docker image is an armhf version of GOGS based on my own debian stable linux image.

## Image dependencies:
- One volume /data/gogs required for persistent storage
- Port 3000 for HTTP access to the GOGS daemon.
- Port 3022 for SSH access to the GOGS daemon.
- User: git (uid: 3000)
- Group: git (gid: 3000)


## Build characteristics:
- Debian stable (kdedesign/debian-stable:latest)
- Go 1.20.2 (go1.20.2.linux-armv6l.tar.gz)
- GOGS 0.13.0 (v0.13.0.tar.gz)

## GOGS build command:
- go build -tags "sqlite cert"

## Typical run command:
```
$ docker run -d --restart always --name=gogs  -p 3022:3022 -p 3000:3000 -v /data/gogs:/data kdedesign/gogs
```

## Default configuration location
The default location of the configuration file app.ini is controlled by the environment variable `GOGS_CUSTOM` and is set to: `GOGS_CUSTOM=/data/custom` in this image.
This means that if you want to create your own configuration file you have to create on your docker volume a directory custom/conf and place your app.ini in there.

## Handy commands:
### Making a backup of gogs, repositories and database
Making a backup of your gogs instance is easy even though it is running in a docker container. All you need is the name of the container to connect to, in the example above the name is 'gogs' (--name=gogs). So start your backup this way:

```
$ docker exec -it gogs /opt/gogs/gogs backup --target=/data/backup
```
Using the command above your backup will be placed in the directory '/data/backup'.
Want to know more or how to restore, please read the article: https://discuss.gogs.io/t/how-to-backup-restore-and-migrate/991

### Restoring a backup
Restoring a backup of your gogs instance is easy even though it is running in a docker container. All you need is the name of the container to connect to, in the example above the name is 'gogs' (--name=gogs). So start your restore this way:
```
docker exec -it gogs /opt/gogs/gogs restore --from /data/backup/gogs-backup-20190125183424.zip -t /data/tmp
```
This is also a way to migrate from an SQLite database to an other database type. 

### Saving SSH keys
If you wish to use a githook, for example to mirror your local gogs repository on GutHub you can make use of a ssh public/private key. These keys typically are placed in the .ssh directory in the home directory of the user.
To place these files you can make a persistent storige of the .ssh directory like this:
```
$ docker run -d --restart always --name=gogs  -p 3022:3022 -p 3000:3000 -v /data/gogs/ssh:/opt/gogs
/.ssh -v /data/gogs:/data kdedesign/gogs
```
Now you can connect to the container and execute a bash shell as the user git:
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
Now alter some code in your repository and push the commit, if all went wel you will see the magic happen!

## More info:
- Check https://github.com/kdeenkhoorn/gogs
- Check https://github.com/gogits/gogs/issues/96
- Check https://hub.docker.com/r/kdedesign/gogs/

Have fun!

Kl@@s
