#!/bin/bash

# Install Docker on Ubuntu 14.04.4 x64
# Ref https://docs.docker.com/engine/installation/linux/ubuntulinux/
# No interactive for now.
export DEBIAN_FRONTEND=noninteractive
# Update your APT package index.
sudo apt-get -y update
# Update package information, ensure that APT works with the https method, and that CA certificates are installed.
sudo apt-get install apt-transport-https ca-certificates htop mc
# Add the new GPG key.
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# Add docker.list
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-trusty experimental" > /etc/apt/sources.list.d/docker.list
# Update your APT package index.
sudo apt-get -y update
# Purge the old repo if it exists.
sudo apt-get purge lxc-docker
# Verify that APT is pulling from the right repository.
sudo apt-cache policy docker-engine
# Install the recommended package.
sudo apt-get -y install linux-image-extra-$(uname -r)
# Ubuntu 14.04 or 12.04, apparmor is required.
sudo apt-get -y install apparmor
# Install Docker.
sudo apt-get -y install docker-engine
# Start the docker daemon.
sudo service docker start
# Validate docker version
docker -v

# install soft
apt-get install -y mc htop git nano lynx curl

# setup swap
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
sysctl vm.swappiness=10
echo "vm.swappiness=10" >> /etc/sysctl.conf
sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf

# init swarm
docker swarm init --advertise-addr 192.168.168.10 >> /root/cluster-info.txt
