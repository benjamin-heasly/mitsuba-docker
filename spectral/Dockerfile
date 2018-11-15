FROM ninjaben/mitsuba-rgb

LABEL authors="Ben Heasly <benjamin.heasly@gmail.com>, Marceli Wac <marceliwac@gmail.com>"

WORKDIR /mitsuba/mitsuba

### edit mitsuba source and config for 31 spectrum bands in 395-705nm
RUN sed 's/SAMPLES=[0-9]*/SAMPLES=31/' build/config-linux-gcc.py > config.py
RUN sed -e 's/SPECTRUM_MIN_WAVELENGTH[ ^I]*[0-9]*$/SPECTRUM_MIN_WAVELENGTH   395/' \
    -e 's/SPECTRUM_MAX_WAVELENGTH[ ^I]*[0-9]*$/SPECTRUM_MAX_WAVELENGTH   705/' \
    --in-place include/mitsuba/core/spectrum.h

### replace previous rgb build with new spectral build
RUN scons
