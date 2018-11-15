FROM ubuntu:14.04

LABEL authors="Ben Heasly <benjamin.heasly@gmail.com>, Marceli Wac <marceliwac@gmail.com>"

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

### mitsuba dependencies
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    scons \
    git \
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
RUN git clone https://www.github.com/mitsuba-renderer/mitsuba.git
RUN cd mitsuba && git checkout 2f9bf64cb49c2b4c1c945e73c50c1c0da9507add && cd ..
WORKDIR /mitsuba/mitsuba
RUN cp build/config-linux-gcc.py config.py \
    && scons

### set up Mitsuba lib and bin paths, like in Mitsuba's own setpath.sh
ENV MITSUBA_DIR /mitsuba/mitsuba
ENV PYTHONPATH /mitsuba/mitsuba/dist/python:/mitsuba/mitsuba/dist/python/2.7:
ENV PATH /mitsuba/mitsuba/wrapper:/mitsuba/mitsuba/dist:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH /mitsuba/mitsuba/dist:

### configure headless X server
### this allows the Mitsba scene importer "mtsimport" to use OpenGL for triagle computations
COPY xorg.conf /etc/X11/xorg.conf
ENV DISPLAY :0

### wrapper to start headless xserver when using mtsimport
COPY ./mtsimport-headless.sh /mitsuba/mitsuba/wrapper/mtsimport
