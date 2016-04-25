# oacis_docker_tutorial

[![GitHub version](https://badge.fury.io/gh/crest-cassia%2Foacis_docker_tutorial.svg)](https://badge.fury.io/gh/crest-cassia%2Foacis_docker_tutorial)
[![docker image](http://img.shields.io/badge/docker_image-ready-brightgreen.svg)](https://hub.docker.com/r/oacis/oacis/)
[![Build Status](https://travis-ci.org/crest-cassia/oacis_docker_tutorial.svg?branch=develop)](https://travis-ci.org/crest-cassia/oacis_docker_tutorial)

You can experience [OAICS](https://github.com/crest-cassia/oacis).

## Quick Start

1. Setup docker engine (version 1.8 or later is required.)

    - See [Docker home page](https://www.docker.com/).
    - If you are Mac or Windows user, install [Docker Toolbox](https://www.docker.com/toolbox).

2. Start an oacis instance
    ```sh
    docker run --name oacis_tutorial -p 3000:3000 -dt oacis/oacis_tutorial
    docker logs -f oacis # wait for boot. exit via Ctrl + C
    ```
    - OACIS is ready when you get the following logs.
        ```
        Progress: |====================================================================|
        bundle exec rails s -d -b 0.0.0.0
        => Booting Thin
        => Rails 4.2.0 application starting in production on http://0.0.0.0:3000
        => Run `rails server -h` for more startup options
        ServiceWorker started.
        JobSubmitterWorker started.
        JobObserverWorker started.
        + echo booted
        booted
        + child=807
        + wait 807
        + tail -f /dev/null
        ```
    - The default port is 3000. (You can choose another port like `-p 3001:3000`.)
    - (for Mac or Windows users) Run the above command in *Docker Quickstart Terminal*.

3. Access OACIS web interface

    - You can access OACIS web interface via a web browser.(`http://localhost:3000`)
    - (Mac or Windows) Access `192.168.99.100` instead of `localhost`.
        - ![docket_tool_ip](https://github.com/crest-cassia/oacis_docker/wiki/images/docker_tool_ip.png)

4. Try Simulations

    - Several simulators have been installed.
    - You can see how to use each simulator on About tab of Simulator page

## Stop and Restart

Find a running `oacis_tutorial` container.
```sh
docker ps
#CONTAINER ID        IMAGE                        COMMAND                        CREATED         STATUS        PORTS                        NAMES
#3edbc17ee5e4        oacis/oacis_tutorial:latest  "./oacis_docker_cmd/o"         1 days ago      Up 23 hours   0.0.0.0:3000->3000/tcp       oacis_tutorial
```

Stop the container.
```sh
docker stop oacis_tutorial
```

Find the stoped `oacis_tutorial` container.
```sh
docker ps -a
#CONTAINER ID        IMAGE                        COMMAND                        CREATED         STATUS                  PORTS                        NAMES
#3edbc17ee5e4        oacis/oacis_tutorial:latest  "./oacis_docker_cmd/o"         1 days ago      Exited (0) 1 week ago   0.0.0.0:3000->3000/tcp       oacis_tutorial
```

Restart the container.
```sh
docker start oacis_tutorial
docker logs -f oacis_tutorial
```

Revome the container.
```sh
docker stop oacis_tutorial
docker rm -v oacis_tutorial
```

## Logging in the container

By logging in the container, you can update the configuration of the container.
For instance, you can install additional packages, set up ssh-agent, and see the logs.

To login the container as a normal user, run

```sh
docker exec -it -u oacis oacis_tutorial bash -l
```

To login as the root user, run

```sh
docker exec -it oacis_tutorial bash
```

## Firewall

Linux users must set up firewall for oacis_docker, otherwise anyone can access your oacis web-browser interface.
`iptables` is an application program for setting up firewall and docker-engine makes iptables configulations.
Run the following command as root on host machine to overwrite the configulations.

```sh
iptables -I FORWARD -i eth+ -o docker0 -p tcp -m tcp --dport 3000 -j DROP
```

If you are also using wifi, you need to run the following command additionally.

```sh
iptables -I FORWARD -i wlan+ -o docker0 -p tcp -m tcp --dport 3000 -j DROP
```

Note: `iptables` configurations are deleted when host OS reboots.

## Contact

- Just send your feedback to us!
    - `oacis-dev _at_ googlegroups.com` (replace _at_ with @)
    - We appreciate your questions, feature requests, and bug reports. Do not hesitate to give us your feedbacks.
- You'll have announcements of new releases if you join the following google group. Take a look at
    - https://groups.google.com/forum/#!forum/oacis-users

## License

  - [oacis_docker_tutorial](https://github.com/crest-cassia/oacis_docker_tutorial) is a part of [OACIS](https://github.com/crest-cassia/oacis).
  - OACIS and oacis_docker_tutorial are published under the term of the MIT License (MIT).
  - Copyright (c) 2014,2015,2016 RIKEN, AICS

