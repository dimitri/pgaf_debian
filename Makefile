DOCKER_CONTAINER_NAME = pgaf_debian

build:
	docker build -t $(DOCKER_CONTAINER_NAME) .

sh:
	docker run --rm -it $(DOCKER_CONTAINER_NAME) bash

.PHONY: build sh
