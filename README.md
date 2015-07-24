# mitsuba-docker
Dockerfile and instructions for building Mitsuba

# Hi!

The `Dockerfile` in this repository represents a complete set of instructions for building Mitsuba on Ubuntu.  You can use this to create a Docker image with Mitsuba in it.

You can also consult this to figure out how to build Mitsuba.  The RUN commands are thing you can run on the command line.  Some of them will require `sudo`.

**Note**: The Mitsuba build with scons takes a while and a lot of memory.  You probably want a newish machine with 4GB+ of RAM.  Or run all of this on a beefy Amazon EC2 instance!

For me (Ben) the build ran out of memory on an Amazon *t2.micro* instance.  On an *m4.xlarge* instance it succeeded after about 35 minutes.

# Build the Docker image

Here's how to build the image in the first place:
 - [install Docker](https://docs.docker.com/installation/)
   - on ubuntu (might be out-dated, here is an [alternative](https://github.com/DavidBrainard/RenderToolboxDevelop/wiki/Matlab-on-Docker-and-EC2#ssh-to-ec2-instance-and-install-docker-with-support-for-large-containers)): `sudo apt-get install docker docker.io`
   - on amazon linux: `sudo yum install docker`
 - `sudo service docker start`
 - [install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   - on ubuntu: `sudo apt-get install git`
   - on amazon linux: `sudo yum install git`
 - `git clone https://github.com/benjamin-heasly/mitsuba-docker.git`
 - `cd mitsuba-docker`
 - `sudo docker build -t my-name/mitsuba-docker:latest .`

# Run the Docker image

Here's how to launch a Docker container from the image, and get command line access:
 - `sudo docker run -t -i my-name/mitsuba-docker:latest "/bin/bash"`

Once you're in, check that you can run multi-spectral and rgb mitsuba and mitsuba importer:
 - `mitsuba-multi`
 - `mmtsimport-multi`
 - `mitsuba-rgb`
 - `mmtsimport-rgb`

# Automated Docker Hub builds?

Since the `Dockerfile` is nearly self-contained, it would make a nice automated build on Docker Hub.  That way, you wouldn't have to build the image yourself.

Unfortunately, the Mitsuba build with scons takes more memory than Docker Hub provisions for automated builds (I think you get 3GB).  So for now you just have to DIY.

If you have a Docker Hub account, you can push up the image manually, then use it from anywhere.  That way, you only have to build the image once:
 - `sudo docker login`
 - `sudo docker push my-name/mitsuba-docker:latest`
