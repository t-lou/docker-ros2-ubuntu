# docker build . --tag ros2:18.04 --build-arg UBUNTU_VERSION=18.04 --build-arg CHOOSE_ROS_DISTRO=crystal
# docker build . --tag ros2:20.04 --build-arg UBUNTU_VERSION=20.04 --build-arg CHOOSE_ROS_DISTRO=foxy

ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

# create normal user so that files in volumes is editable
RUN useradd usr
RUN mkdir -m 0777 /home/usr

# prepare dependencies
RUN apt update
RUN apt upgrade -y
RUN apt install -y curl gnupg2 lsb-release sudo # for convenience, this supports copied commands with sudo

# install tzdata and keyboard to avoid interrupt
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ENV TZ=Etc/GMT
RUN DEBIAN_FRONTEND="noninteractive" apt -y install tzdata keyboard-configuration

# set up the repo
RUN curl http://repo.ros2.org/repos.key | sudo apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt update

# install ros and two useful dependencies
ARG CHOOSE_ROS_DISTRO
RUN apt install -y ros-${CHOOSE_ROS_DISTRO}-desktop
RUN apt install -y python3-rosdep2 python3-argcomplete
RUN apt autoclean && apt clean
