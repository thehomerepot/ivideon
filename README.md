[linuxserverurl]: https://linuxserver.io
[thehomerepoturl]: https://github.com/thehomerepot
[appurl]: https://www.ivideon.com
[hub]: https://hub.docker.com/r/thehomerepot/ivideon/

[![thehomerepot](https://github.com/thehomerepot/media/raw/master/thehomerepot_banner_medium.png)][thehomerepoturl]

Based on the amazing work by [LinuxServer.io][linuxserverurl], TheHomeRepot aims to provide additional quality, reliable containers. 

# thehomerepot/ivideon

[Ivideon][appurl] is a free to use (with [limitations](https://www.ivideon.com/plans-for-home/)) [VMS](https://en.wikipedia.org/wiki/Video_management_system).

[![Ivideon](https://github.com/thehomerepot/media/raw/master/ivideon-icon.png)][appurl]

## Usage
Any time you want to create/modify your server settings, you'll need to run this docker command. Configuration is accomplished via X11 forwarding. As long as the user you're executing the docker command from has a proper ~/.Xauthority file and you have an X11 server listening, this will work.

Initialization/Configuration
```
docker run -it --rm \
--net=host \
-v </path/to/config>:/config \
-v </path/to/recordings>:/archive \
-e PUID=<UID> -e PGID=<GID> \
-e TZ=<timezone> \
-v ~/.Xauthority:/config/.Xauthority \
-e DISPLAY \
thehomerepot/ivideon /app/x11_config.sh
```

Post-Initializtion
```
docker run -d -P \
--name=ivideon \
--restart=unless-stopped \
-v </path/to/config>:/config \
-v </path/to/recordings>:/archive \
-e PUID=<UID> -e PGID=<GID> \
-e TZ=<timezone> \
thehomerepot/ivideon
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.


* `-v /config` - Configuration files
* `-v /archive` - Recordings will be landed here.
* `-e PGID=` for for GroupID - see below for explanation
* `-e PUID=` for for UserID - see below for explanation
* `-e TZ` - for timezone information *eg Europe/London, etc*

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify. DO NOT USE ROOT

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Using the software

You will need to install and run the [Ivideon client](https://www.ivideon.com/downloads/)

## Info

* Shell access whilst the container is running: `docker exec -it ivideon /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ivideon`


## Versions

+ **2017.09.27:** Initial creation
