#!/usr/bin/env bash

sudo apt-get remove -qq docker docker-engine docker.io containerd runc

# Update the apt package index
sudo apt-get update --qq -q

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y -qq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Get Docker stable repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -qq
sudo apt-get install -y -qq docker-ce docker-ce-cli containerd.io

# Docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Post installation steps for linux
# https://docs.docker.com/install/linux/linux-postinstall/

sudo groupadd docker
sudo usermod -aG docker $USER

if [ -d $HOME/.docker ]; then
  sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
  sudo chmod g+rwx "$HOME/.docker" -R
fi
