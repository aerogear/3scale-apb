DOCKERHOST = docker.io
DOCKERORG = feedhenry
TAG = latest
USER=$(shell id -u)
PWS=$(shell pwd)

build_and_push: apb_build docker_push apb_push

.PHONY: build
build: apb_build

.PHONY: apb_build
apb_build:
	docker run --rm -u $(USER) -v $(PWD):/mnt:z feedhenry/apb prepare
	docker build -t $(DOCKERHOST)/$(DOCKERORG)/3scale-apb:$(TAG) .

.PHONY: docker_push
docker_push:
	docker push $(DOCKERHOST)/$(DOCKERORG)/3scale-apb:$(TAG)

.PHONY: apb_push
apb_push:
	docker run --rm -u $(USER) -v $(PWD):/mnt:z feedhenry/apb push