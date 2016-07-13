FROM ubuntu:14.04

MAINTAINER Ben Heasly <benjamin.heasly@gmail.com>

### headless X server dependencies
RUN apt-get update \
    && apt-get install -y \
    libx11-dev \
    libxxf86vm-dev \
    x11-xserver-utils \
    x11proto-xf86vidmode-dev \
    x11vnc \
    xpra \
    xserver-xorg-video-dummy \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove

### headless X server
### this allows the Mitsba scene importer "mtsimport" to use OpenGL for triagle computations
COPY xorg.conf /etc/X11/xorg.conf
RUN echo 'xpra start :0' > /etc/bash.bashrc
ENV DISPLAY :0

### mitsuba dependencies
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    scons \
    mercurial \
    qt4-dev-tools \
    libpng12-dev \
    libjpeg-dev \
    libilmbase-dev \
    libxerces-c-dev \
    libboost-all-dev \
    libopenexr-dev \
    libglewmx-dev \
    libxxf86vm-dev \
    libpcrecpp0 \
    libeigen3-dev \
    libfftw3-dev \
    wget \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove

WORKDIR /mitsuba

RUN wget http://www.mitsuba-renderer.org/releases/current/trusty/collada-dom-dev_2.4.0-1_amd64.deb \
    && wget http://www.mitsuba-renderer.org/releases/current/trusty/collada-dom_2.4.0-1_amd64.deb \
    && dpkg --install collada-dom*.deb

### build Mitsuba
RUN hg clone --insecure https://www.mitsuba-renderer.org/hg/mitsuba
WORKDIR /mitsuba/mitsuba
RUN cp build/config-linux-gcc.py config.py \
    && scons

### set up Mitsuba libs and path before running any given commands
COPY mitsuba-entrypoint.sh /
ENTRYPOINT ["/mitsuba-entrypoint.sh"]

