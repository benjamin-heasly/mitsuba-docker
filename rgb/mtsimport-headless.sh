#! /bin/bash

# start a headless x server so that Mitsuba can triangulate with OpenGL
xpra start :0 --no-pulseaudio

# hack to let the x server come up
sleep 1

# proceed with mtsimport
/mitsuba/mitsuba/dist/mtsimport "$@"

