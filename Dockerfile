FROM python:3.6.4-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-python)
LABEL description="Python 3.6.4 Development Image"

ENV DOCKERIZE_VERSION=v0.6.0

COPY ./bashrc /home/sprout/.bashrc
COPY ./vimrc /home/sprout/.vimrc
COPY ./initenv /usr/local/bin/initenv

RUN apk --no-cache add -U \
    ca-certificates \
    openssl \
    vim \
    bash \
  && update-ca-certificates \
  && ln -sf /usr/bin/vim /usr/bin/vi \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && pip install virtualenv \
  && adduser -s /bin/bash -D sprout \
  && mkdir -p /work/app && chown -R sprout:sprout /work /home/sprout/.bashrc /home/sprout/.vimrc \
  && wget -P /home/sprout https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore

USER sprout
WORKDIR /work/app
