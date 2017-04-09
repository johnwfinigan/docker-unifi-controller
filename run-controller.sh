#!/bin/bash

docker run -d \
			-p 8080:8080 -p 8443:8443 -p 8880:8880 -p 8843:8843 -p3478:3478/udp \
			-v /srv/docker/unifi/unifi:/usr/lib/unifi/data:Z \
			-v /srv/docker/unifi/mongo:/data/db:Z \
			--name unifi johnwfinigan/unifi-controller
