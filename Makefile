
IMAGE_VERSION=3.6.4
IMAGE_NAME=chrisgarrett/python

all: build

prep:
	VERSION=${IMAGE_VERSION} envsubst '$${VERSION}' < ./templates/Dockerfile.template > Dockerfile
	VERSION=${IMAGE_VERSION} envsubst '$${VERSION}' < ./templates/README.md.template > README.md

build: prep
	docker build --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .

run:
	docker run --rm -it ${IMAGE_NAME}:${IMAGE_VERSION} python --version

bash:
	docker run --rm -it -v `pwd`/src:/work/app ${IMAGE_NAME}:${IMAGE_VERSION} bash

init:
	docker run --rm -it \
		-v `pwd`/src:/work/app \
		${IMAGE_NAME}:${IMAGE_VERSION} \
		initenv

django:
	docker run --rm -it \
		-v `pwd`/src:/work/app \
		${IMAGE_NAME}:${IMAGE_VERSION} \
		pip install --user --no-cache-dir -r requirements.txt
