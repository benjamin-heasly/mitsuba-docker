FROM ubuntu:14.04

MAINTAINER Ben Heasly <benjamin.heasly@gmail.com>

### mitsuba dependencies
apt-get update \
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

RUN wget http://www.mitsuba-renderer.org/releases/current/trusty/collada-dom-dev_2.4.0-1_amd64.deb \
    && wget http://www.mitsuba-renderer.org/releases/current/trusty/collada-dom_2.4.0-1_amd64.deb \
    && dpkg --install collada-dom*.deb

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
ADD xorg.conf /etc/X11/xorg.conf
RUN echo 'xpra start :0' > /etc/bash.bashrc
ENV DISPLAY :0

### get Mitsuba source
RUN mkdir /home/rtb/mitsuba-src
WORKDIR /home/rtb/mitsuba-src
RUN hg clone --insecure https://www.mitsuba-renderer.org/hg/mitsuba

### build and install RBG Mitsuba
WORKDIR /home/rtb/mitsuba-src/mitsuba
RUN cp build/config-linux-gcc.py config.py \
    && scons \
    && mkdir -p /home/rtb/mitsuba-rgb \
    && cp -r dist/* /home/rtb/mitsuba-rgb

### edit mitsuba source and config for 31 spectrum bands in 395-705nm
RUN sed 's/SAMPLES=[0-9]*/SAMPLES=31/' build/config-linux-gcc.py > config.py
RUN sed -e 's/SPECTRUM_MIN_WAVELENGTH[ ^I]*[0-9]*$/SPECTRUM_MIN_WAVELENGTH   395/' \
    -e 's/SPECTRUM_MAX_WAVELENGTH[ ^I]*[0-9]*$/SPECTRUM_MAX_WAVELENGTH   705/' \
    --in-place include/mitsuba/core/spectrum.h

### build and install multispectral Mitsuba
RUN scons \
    && mkdir -p /home/rtb/mitsuba-multi \
    && cp -r dist/* /home/rtb/mitsuba-multi


