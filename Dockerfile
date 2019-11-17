FROM python:3.6.8-alpine3.8
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-python)
LABEL description="Python 3.6.8 Development Image"

ENV DOCKERIZE_VERSION=v0.6.0
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/bash_profile /home/sprout/.bash_profile
COPY ./scripts/bashrc /home/sprout/.bashrc
COPY ./scripts/vimrc /home/sprout/.vimrc
COPY ./scripts/initenv /usr/local/bin/initenv
COPY ./bootstrap /home/sprout/bootstrap

RUN apk --no-cache add -U \
    ca-certificates \
    libressl \
    vim \
    bash \
    git \
    make \
    build-base \
    automake \
    autoconf \
    nasm \
    py-pip \
    nodejs \
    nodejs-npm \
    linux-headers \
    alpine-sdk \
    postgresql-dev \
    libpng-dev \
    jpeg-dev \
    zlib-dev \
    libc-dev \
    musl-dev \
    musl-utils \
    musl-dbg \
    libevent-dev \
    python3-dev \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    pcre-dev \
    readline \
    gfortran \
  && apk --no-cache add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    libcrypto1.1 \
  && apk --no-cache add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    gdal-dev \
    geos-dev \
    proj4-dev \
  && update-ca-certificates \
  && npm i -g npx \
  && npm i -g shx \
  && npm i -g nodemon \
  && cp -r /usr/include/libxml2/libxml/ /usr/include \
  && ln -s /usr/lib/libreadline.so.7 /usr/lib/libreadline.so.6 \
  && ln -sf /usr/bin/vim /usr/bin/vi \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && pip install --no-cache-dir --upgrade pip \
  && pip install virtualenv invoke \
  && adduser -s /bin/bash -D sprout \
  && wget -P /home/sprout/bootstrap https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore \
  && mkdir -p /work/app && chown -R sprout:sprout /work /home/sprout

USER sprout
WORKDIR /work/app
ENTRYPOINT ["/entrypoint.sh"]
