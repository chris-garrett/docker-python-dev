
IMAGE_VERSION=3.6.4
IMAGE_NAME=chrisgarrett/python
RUN_ARGS=--rm -it -v `pwd`/src:/work/app -p 8000:8000 ${IMAGE_NAME}:${IMAGE_VERSION}

all: build

prep:
	VERSION=${IMAGE_VERSION} envsubst '$${VERSION}' < ./templates/Dockerfile.template > Dockerfile
	VERSION=${IMAGE_VERSION} envsubst '$${VERSION}' < ./templates/README.md.template > README.md

build: prep
	docker build --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .

run:
	docker run --rm -it ${IMAGE_NAME}:${IMAGE_VERSION} python --version

bash:
	docker run ${RUN_ARGS} bash

init:
	docker run ${RUN_ARGS} initenv

install:
	docker run ${RUN_ARGS} invoke install

up:
	docker run ${RUN_ARGS} invoke up
