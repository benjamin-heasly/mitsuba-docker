#! /bin/bash

# start a headless x server
xpra start :0 --no-pulseaudio

# hack to let the x server come up
sleep 1

# proceed with given commands
exec "$@"

