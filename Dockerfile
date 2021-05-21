FROM debian:sid

ENV TAR v1.5.2.tar.gz
ENV ORIG pg-auto-failover_1.5.2.orig.tar.gz
ENV WORKDIR /usr/src/pg_auto_failover-1.5.2
ENV ARCHIVE https://github.com/citusdata/pg_auto_failover/archive/refs/tags/
ENV RELEASE ${ARCHIVE}${TAR}

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        build-essential \
        devscripts \
        debhelper \
        autotools-dev \
        flex \
        libedit-dev \
        libpam0g-dev \
        libreadline-dev \
        libselinux1-dev \
        libxslt1-dev \
        libssl-dev \
        libkrb5-dev \
        libz-dev \
        postgresql-server-dev-all \
        postgresql-common \
        python3-sphinx \
        lintian \
        curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

RUN curl -L -o ${TAR} ${RELEASE}
RUN tar xf ${TAR}
RUN mv ${TAR} ${ORIG}

WORKDIR ${WORKDIR}
COPY debian/ ./debian/

RUN pg_buildext updatecontrol
RUN dpkg-buildpackage --no-sign

WORKDIR /usr/src

RUN lintian --suppress-tags bad-whatis-entry *.changes
