FROM python:3.6.4-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-python)
LABEL description="Python 3.6.4 Development Image"

ENV DOCKERIZE_VERSION=v0.6.0

COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/bash_profile /home/sprout/.bash_profile
COPY ./scripts/bashrc /home/sprout/.bashrc
COPY ./scripts/vimrc /home/sprout/.vimrc
COPY ./scripts/initenv /usr/local/bin/initenv
COPY ./bootstrap /home/sprout/bootstrap

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
    jpeg-dev \
    zlib-dev \
    py-pip \
    musl-dev \
    musl-utils \
    musl-dbg \
    libevent-dev \
    python3-dev \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    openssl-dev \
    nodejs \
  && update-ca-certificates \
  && npm i -g npx \
  && npm i -g nodemon \
  && cp -r /usr/include/libxml2/libxml/ /usr/include \
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
