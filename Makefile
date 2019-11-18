
PYTHON_VERSION=3
ALPINE_VERSION=3.10
DOCKERIZE_VERSION=v0.6.0
IMAGE_VERSION=${PYTHON_VERSION}
IMAGE_NAME=chrisgarrett/python-dev
RUN_ARGS=--rm -it -v `pwd`/src:/work/app -p 8000:8000 ${IMAGE_NAME}:${IMAGE_VERSION}

all: build

prep:
	VERSION=${IMAGE_VERSION} ALPINE_VERSION=${ALPINE_VERSION} PYTHON_VERSION=${PYTHON_VERSION} DOCKERIZE_VERSION=${DOCKERIZE_VERSION} envsubst '$${VERSION} $${ALPINE_VERSION} $${PYTHON_VERSION} $${DOCKERIZE_VERSION}' < ./templates/Dockerfile.template > Dockerfile
	VERSION=${IMAGE_VERSION} ALPINE_VERSION=${ALPINE_VERSION} PYTHON_VERSION=${PYTHON_VERSION} DOCKERIZE_VERSION=${DOCKERIZE_VERSION} envsubst '$${VERSION} $${ALPINE_VERSION} $${PYTHON_VERSION} $${DOCKERIZE_VERSION}' < ./templates/README.md.template > README.md

build: prep
	#docker build --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .
	docker build --no-cache --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .

run:
	docker run --rm -it ${IMAGE_NAME}:${IMAGE_VERSION} python --version

bash:
	docker run ${RUN_ARGS} bash

init:
	docker run ${RUN_ARGS} initenv

scrapy::
	docker run ${RUN_ARGS} bash -c "pip install Scrapy && pip freeze > requirements.txt &&scrapy startproject tutorial"
