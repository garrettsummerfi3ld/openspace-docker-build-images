# Docker Containers
This repository is a collection of a number of Dockerfile configuration files that can be used to achieve different actions surrounding OpenSpace. The files are separated into subfolders that make clear what the files are used for. The rest of this document explains how to install Docker and then how to use each of the folders and what they contain. The general gist is that a Docker container is like a virtual machine, but a lot easier (and faster) to setup. One important difference is that a Docker container will (in general) forget everything that you have done to it in an interactive session. This is great for reproducibility, but can be surprising.

## Installation
### Windows
If you are on Windows 11, the easiest way is to open a Powershell terminal and install Docker from there: `winget install Docker.DockerDesktop`.  Otherwise you can download the installer from [here](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe).

### Linux
You can install Docker either via your package manager or through Docker themselves. There is a Docker Desktop application you can use to help develop with Docker on Linux as well. More information can be found [here](https://docs.docker.com/engine/install/).

### macOS
You can install Docker Desktop by going [here](https://docs.docker.com/get-docker/) to install Docker Desktop. This will install the Docker Desktop application and the necessary CLI for Docker.

## Getting started
Please note that this is just a quick and dirty getting started guide. For all commands refer to [documentation](https://docs.docker.com/) for more information. The general workflow for Docker is that we _build_ an **image** from a **Dockerfile**, and then _run_ an **image** as a **container**.

To build a Docker image, on the commandline call: `docker build --tag {tag} --file {file}`. Where `{tag}` is the new name of the image that is to be built and the `{file}` is the Dockerfile that contains the instructions how to build it. For example if there is a `container.Dockerfile` in the local directory and we want to create an image called "my-first-image", we would call `docker build --tag my-first-image --file container.Dockerfile .`. Note the extra `.` at the end, which is easy to forget.

To then run that Docker image as a container call: `docker run --gpus all --interactive --tty {tag}`, where `{tag}` is the name of an image that has previously been built. The combination of `--interactive` and `--tty` means that we automaticaly switch into that container and get a commandline inside that we can execute code from. This is only necessary if we are dealing with a container that is not a single fire-and-forget. Continuing the example from before, we could run our new image like so: `docker run --gpus all --interactive --tty my-first-image`. The terminal that we ran the code on will then switch over and we are now executing commands inside the Docker container. Especially when running containers for longer time, it can be useful to limit the resources that every individual container has access to. The `docker run` command has the ability to take `--cpus="{n}"` to set the number of available CPUs for the container to use `--cpus="1.25"` would allow the container to use one CPU fully and a second one to 25% capacity. `--memory="{}"` sets the amount of system memory that the container can use, for example `--memory="8G"` would limit the container to 8 GiB of RAM.

Specifically for containers that are going to be reused, it can be useful to give a `--name {}` to the container which makes it easier to recognize in the containers list.

Please also note that the example commands here are meant to be executed from the same folder in which the Dockerfile is located.

# `build`
The Dockerfiles in this folder create build environments that install all dependencies necessary to compile OpenSpace. The `build/build-all.bat` script will automatically build all of the images contained in the folder on Windows machines. The `build/build-all.sh` script will do the same thing as the Windows script for Linux/macOS. The container will also contain a `build.sh` at the root of the filesystem that will automatically clone OpenSpace and then build it using the environment. The `build.sh` script can take one optional argument, which is the branch that should be built. If the parameter is left out, the `master` branch is built instead.

The naming scheme for the Docker files is: `{OS/distribution}-{OS version}-{compiler}.Dockerfile`.


# `jenkins`
The Dockerfiles in this folder contain Dockerfile instructions to use any other image as a Jenkins build node for the [dev.openspaceproject.com](dev.openspaceproject.com) page. Currently, there is only a single Dockerfile, that can be used to Jenkins-ify any of the Docker images defined in the `build` folder. This image is different in two regards; 1. it takes arguments at image build time and 2. it runs automatically and does not need to be called interactively.

To build the Jenkins docker, follow the following steps:
1. Build one of the images from the `build` folder, for example "ubuntu-2204-clang14.Dockerfile" through `docker build --tag openspace-ubuntu-2204-clang14 --file ubuntu-2204-clang14.Dockerfile .`. The specific `tag` name is arbitrary
1. Build the Jenkins image, which requires three arguments to the build:
   1. `IMAGE`: The `tag` of the image that should be used as the basis for the Jenkins machine
   1. `COMPUTER_NAME`: The name of the computer on [dev.openspaceproject.com](dev.openspaceproject.com) we want to host (for example `linux-clang-1`, `windows-2`, etc)
   1. `SECRET`: The secret that needs to be transmitted to the main Jenkins to authenticate the server. You can find this in the `systemInfo` subpage of a specific node (for example: http://dev.openspaceproject.com/computer/linux%2Dclang%2D1/systemInfo). Never commit this secret to any GitHub repository or share it with anyone outside of the organization
   1. Build the Jenkins image and provide the arguments: `docker build --tag jenkins-openspace-ubuntu-2204-clang14 --file jenkins.Dockerfile --build-arg IMAGE=openspace-ubuntu-2204-clang14 --build-arg COMPUTER_NAME=linux-clang-1 --build-arg SECRET=mysecret .`. The `tag`, again, is arbitrary, but it makes sense to use something that is related to the tag specified in `IMAGE`
1. Run the Docker image in a container. The Jenkins container will automatically set everything up, so no `--interactive` is necessary. If you don't want to see what happens either, the `--tty` can be omitted as well, leading to: `docker run jenkins-openspace-ubuntu-2204-clang14`. If this is installed permanently on a machine also consider adding `--restart always` to make sure that the container is always running and give it a `--name {name}` at the same time so that the container is recognizable and `--detach` so that it does not attach to the current commandline window.


# `tools`
Important: These Dockerfiles all require the `build/build-all.bat` to have been executed as they rely on the images created by it.

The Dockerfiles in this folder setup an environment to use various useful tools easily, for example clang-tidy or static code analyzers.
To build any of the docker images, follow the following steps:
1. Build all the images in the `build` folder by using the `build/build-all.bat` scripts
1. Build the tool image you want to use: `docker build --tag tool-openspace-clang_tidy --file clang_tidy.Dockerfile .`. The specific `tag` is arbitrary
1. Run the Docker image in a container: `docker run  --tty --interactive tool-openspace-clang_tidy`.
