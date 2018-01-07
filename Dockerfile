FROM python:3.6.4-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-python)
LABEL description="Python 3.6.4 Development Image"

ENV DOCKERIZE_VERSION=v0.6.0

COPY ./entrypoint.sh /entrypoint.sh
COPY ./bash_profile /home/sprout/.profile
COPY ./vimrc /home/sprout/.vimrc
COPY ./initenv /usr/local/bin/initenv
COPY ./tasks.py /home/sprout/bootstrap/tasks.py

RUN apk --no-cache add -U \
    ca-certificates \
    openssl \
    vim \
    bash \
    postgresql-dev \
    git \
    make \
    build-base \
    automake \
    autoconf \
    nasm \
    libpng-dev \
  && update-ca-certificates \
  && ln -sf /usr/bin/vim /usr/bin/vi \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && pip install virtualenv invoke \
  && adduser -s /bin/bash -D sprout \
  && wget -P /home/sprout/bootstrap https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore \
  && mkdir -p /work/app && chown -R sprout:sprout /work /home/sprout 

USER sprout
WORKDIR /work/app
ENTRYPOINT ["/entrypoint.sh"]
