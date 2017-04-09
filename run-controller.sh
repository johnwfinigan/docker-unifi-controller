docker run -d \
			-p 8080:8080 -p 8443:8443 -p 8880:8880 -p 8843:8843 -p3478:3478 \
			-v /srv/docker/unifi:/usr/lib/unifi/data:Z \
			--name unifi johnwfinigan/unifi-controller
