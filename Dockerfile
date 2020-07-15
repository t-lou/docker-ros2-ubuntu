# docker build . --tag ros2:18.04 --build-arg UBUNTU_VERSION=18.04 --build-arg CHOOSE_ROS_DISTRO=crystal
# docker build . --tag ros2:20.04 --build-arg UBUNTU_VERSION=20.04 --build-arg CHOOSE_ROS_DISTRO=foxy

ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

# prepare dependencies
RUN apt update && apt upgrade -y && apt install -y curl gnupg2 lsb-release sudo

# create normal user so that files in volumes is editable
RUN useradd -m usr && echo "usr:usr" | chpasswd && usermod -aG sudo usr

# install tzdata and keyboard to avoid interrupt
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ENV TZ=Etc/GMT
RUN DEBIAN_FRONTEND="noninteractive" apt -y install tzdata keyboard-configuration

# set up the repo
RUN curl http://repo.ros2.org/repos.key | sudo apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# install ros and two useful dependencies
ARG CHOOSE_ROS_DISTRO
RUN apt update && \
    apt install -y ros-${CHOOSE_ROS_DISTRO}-desktop python3-rosdep2 python3-argcomplete
RUN apt autoclean && apt clean
