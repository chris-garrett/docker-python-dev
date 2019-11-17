FROM python:3.7.5-alpine3.10
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-python)
LABEL description="Python 3.7.5 Development Image"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH /usr/lib/python3.7/site-packages

COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/bash_profile /home/sprout/.bash_profile
COPY ./scripts/bashrc /home/sprout/.bashrc
COPY ./scripts/vimrc /home/sprout/.vimrc
COPY ./scripts/initenv /usr/local/bin/initenv
COPY ./bootstrap /home/sprout/bootstrap

RUN set -ex \
  && apk update \
  && apk add -U \
    alpine-sdk \
    autoconf \
    automake \
    bash \
    build-base \
    ca-certificates \
    git \
    jpeg-dev \
    json-c \
    libc-dev \
    libevent-dev \
    libffi-dev \
    libpng-dev \
    libtool \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    musl-dbg \
    musl-dev \
    musl-utils \
    nasm \
    nodejs \
    nodejs-npm \
    openssl \
    pcre-dev \
    postgresql-dev \
    python3-dev \
    vim \
    wget \
    yarn \
    zlib-dev \
  && apk --no-cache add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    cython3 \
    gfortran \
    libcrypto1.1 \
    libgfortran \
    readline \
  && apk --no-cache add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    geos \
    geos-dev \
    gdal \
    gdal-dev \
    proj \
    proj-dev \
  && apk --no-cache add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    lapack \
    lapack-dev \
    py3-numpy \
    py3-numpy-f2py \
    py3-numpy-dev \
    py3-scipy \
  && update-ca-certificates \
  && pip install --no-cache --upgrade setuptools wheel virtualenv \
  && yarn global add npx shx nodemon \
  && cp -r /usr/include/libxml2/libxml/ /usr/include \
  && ln -sf /usr/bin/vim /usr/bin/vi \
  && wget https://github.com/jwilder/dockerize/releases/download/v0.6.0/dockerize-alpine-linux-amd64-v0.6.0.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-v0.6.0.tar.gz \
  && rm dockerize-alpine-linux-amd64-v0.6.0.tar.gz \
  && adduser -s /bin/bash -D sprout \
  && wget -P /home/sprout/bootstrap https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore \
  && mkdir -p /work/app && chown -R sprout:sprout /work /home/sprout \
  && rm -fr /var/cache/apk/*

USER sprout
WORKDIR /work/app
ENTRYPOINT ["/entrypoint.sh"]
