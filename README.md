# docker-ros2-ubuntu

This docker file should create docker image for ros2 with either ubuntu 18.04 or 20.04.

## Build
- docker build . --tag ros2:18.04 --build-arg UBUNTU_VERSION=18.04 --build-arg CHOOSE_ROS_DISTRO=crystal
- docker build . --tag ros2:20.04 --build-arg UBUNTU_VERSION=20.04 --build-arg CHOOSE_ROS_DISTRO=foxy

## Use
docker run --user usr -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri -e DISPLAY=:0 -it ros2:20.04

![Image of Yaktocat](https://github.com/t-lou/docker-ros2-ubuntu/blob/master/screenshot.png)