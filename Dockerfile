FROM debian:sid

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        devscripts \
        debhelper \
        autotools-dev \
        flex \
        libedit-dev \
        libpam0g-dev \
        libreadline-dev \
        libselinux1-dev \
        libxslt1-dev \
        postgresql-server-dev-all \
        postgresql-common \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/pgaf
COPY debian/ ./debian/

RUN pg_buildext updatecontrol
RUN dpkg-buildpackage --no-sign
