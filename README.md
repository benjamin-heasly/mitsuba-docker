# mitsuba-docker
Dockerfile and instructions for building Mitsuba

# Hi

The `Dockerfile` in this repository represents a complete set of instructions for building Mitsuba on Ubuntu.  You can use this to create a Docker image with Mitsuba in it.

You can also consult this to figure out how to build Mitsuba.  The RUN commands are thing you can run on the command line.  Some of them will require `sudo`.

# Build the Docker image

Here's how to build the image in the first place:
 - [install Docker](https://docs.docker.com/installation/)
 - [install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   - on ubuntu: sudo apt-get install git
   - on amazon linux: sudo yum install git
 - git clone https://github.com/benjamin-heasly/mitsuba-docker.git
 - cd mitsuba-docker
 - sudo docker build -t my-name/mitsuba-docker:latest .

# Run the Docker image

Here's how to launch a Docker container from the image, and get command line access:
 - sudo docker run -t -i my-name/mitsuba-docker:latest "/bin/bash"

# Automated Docker Hub builds?

Since the `Dockerfile` is nearly self-contained, it would make a nice automated build on Docker Hub.  That way, you wouldn't have to build the image yourself.

Unfortunately, the Mitsuba build with scons takes more memory than Docker Hub provisions for automated builds (I you get think 3GB).  So for now you just have to DIY.

If you have a Docker Hub account, you can push up the image and reuse it anywhere.  That way, you only have to build the image once:
 - sudo docker login
 - sudo docker push my-name/mitsuba-docker:latest
