USER = johnwfinigan
NAME = unifi-controller
REGISTRY = 
REPO = $(REGISTRY)$(USER)/$(NAME)
VERSION = latest


LVOL = /docker/unifi/data
RVOL = /usr/lib/unifi/data



.PHONY: all build test tag_latest release ssh

all: build tag_latest push

push: push_latest
push_latest:
	docker push $(REPO):latest


build:
	docker build -t="$(REPO):$(VERSION)" --rm --no-cache .




tag_latest:
	docker tag  $(REPO):$(VERSION) $(REPO):latest

release: test tag_latest
	@if ! docker images $(REPO) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(REPO) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(REPO)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

rm:
	docker stop $(NAME) || echo "container not running yet" && docker rm $(NAME) || echo "no container count yet"
