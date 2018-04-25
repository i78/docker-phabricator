# Docker-Compose Appliance for Phabricator

## Building Containers
Either use the images from docker hub to quickly deploy your Phabricator instance, or use the Makefile from this repo to build and tag your own containers.

```
make
```

## Installation and Deployment

### Configuration before first start:

Use your actual hostname:
```
environment:
  - PHABRICATOR_HOSTNAME=(hostname here)
  - PHABRICATOR_BASE_URL=https://(your domainname here)
```

If you are using the (awesome) Traefik reverse proxy, you might want to adapt the Traefik annotations in the docker-compose recipe:

```
traefik.frontend.rule=Host:phabricator.localhost" // your host instead..
```

Then, Simply run the docker-compose recipe

```
docker-compose -d up
```



## Update and maintainance

### Updating Phabricator
Either just build and deploy a new container with the latest version, or update the active container by using the update script:

```
docker exec -ti (container-id) /scripts/update.sh
```

### Backing up Phabricator
Given a volume link at /backup, the backup script can be called with the commandline below

```
docker exec -ti (container-id) /scripts/backup.sh
```