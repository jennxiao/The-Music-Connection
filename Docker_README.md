### Docker

This file is for future developers of this project, and assumes that those developers are not familiar with Docker. Docker is software that provides OS-level virtualization; you can treat it as software that sets up virtual machines.

You can download Docker on their official website: https://www.docker.com/

This project has a Dockerfile in order to homogenize setup. Using Docker is not required to run this project; however, this is useful in debugging tests that pass locally but fail in TravisCI. Here is a brief crash course on how to use Docker.

If you are running Windows, you must enable Hyper-V to use Docker. Note that using other virtual machine software (such as VMWare or Oracle VirtualBox) may interfere with Hyper-V configuration and prevent Docker from launching. If this occurs:

1. Ensure that virtualization is enabled in BIOS
2. Ensure that Hyper-V is enabled in Windows features
3. Run `bcdedit set hypervisorlaunchtype auto` in command prompt as administrator.
4. Ask Google
5. Ask an exorcist

Docker acts as a modular virtual machine. It simulates a multi-service setup ("layers") and composes them into a single file ("image"). Then Docker runs these images in a virtual machine ("container"). This project has two layers: PostreSQL and The-Music-Connection. The PostreSQL layer can be optionally disabled, and The-Music-Connection will use sqlite3 as the database instead. Use PostresSQL for production and sqlite3 for development.

First run `docker pull travisci/ubuntu-ruby:16.04`. This pulls the Docker image named ubuntu-ruby owned by travisci with the version tag 16.04.

Run `docker-compose build` then `docker run the-music-connection_web:latest` to build an image of the application inside a newly-created container without the PostresQL layer. Run `docker-compose up --build` to build and run an image of the application inside a newly-created container. If another container is already using the port, you can kill it by running `docker stop <CONTAINER_NAME>`. You can find the container name by running `docker ps`.

In order to edit the configuration of image building, edit `docker-compose.yml`. In order to edit the configuration of application startup, edit `Dockerfile`.

The motivation behind setting up Docker was to run a local TravisCI instance in order to figure out why Selenium driver was failing without clogging up the git logs. Unfortunately after many, many hours of research and experimentation it appears that TravisCI has removed information pertaining to setting up a local TravisCI instance and no longer endorses such practices.
