# mitsuba-docker
Dockerfile and instructions for building Mitsuba

# Hello!

The `Dockerfiles` in this repository represent complete instructions for building [mitsuba](https://www.mitsuba-renderer.org/) on Ubuntu.  You can use this to create a Docker image with Mitsuba in it.

You can also consult this to figure out how to build Mitsuba.  The RUN commands are thing you can run on the command line.  Some of them will require `sudo`.

The build comes in two flavors.  `/rgb` builds Mitsuba in standard RGB mode.  `/spectral` builds Mitsuba with 31 spectrum slices in the range 395nm-405nm.

# Get the Docker Image

This Docker images are is hosted on DockerHub.  See [rgb](https://hub.docker.com/r/ninjaben/mitsuba-rgb/) and [spectral](https://hub.docker.com/r/ninjaben/mitsuba-spectral/).  You can obtain them locally with:
```
sudo docker pull ninjaben/mitsuba-rgb
sudo docker pull ninjaben/mitsuba-spectral
```

Or you can build them yourself from the Dockerfile:
```
git clone https://github.com/benjamin-heasly/mitsuba-docker.git
cd mitsuba-docker
sudo docker build -t your-name/mitsuba-rgb/ ./rgb
sudo docker build -t your-name/mitsuba-spectral/ ./spectral
```

# Run a Docker Container

You can launch a Docker container from one of these images and use it just like a Mitsuba executable:
```
sudo docker run -ti ninjaben/mitsuba-rgb mitsuba -h
# or
sudo docker run -ti ninjaben/mitsuba-spectral mitsuba -h
```

To give the container access to your Mitsuba scene files, mount in the current folder as a temporary volume:
```
sudo docker run -ti --rm -v `pwd`:`pwd` ninjaben/mitsuba-rgb mitsuba myScene.xml
# or
sudo docker run -ti --rm -v `pwd`:`pwd` ninjaben/mitsuba-spectral mitsuba myScene.xml
```
