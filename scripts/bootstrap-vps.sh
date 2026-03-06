#!/bin/bash

# Exit on any error
set -e

# Update and upgrade packages
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install sops
sudo curl -Lo /usr/local/bin/sops "https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux"
sudo chmod +x /usr/local/bin/sops

# Install age
sudo curl -Lo /usr/local/bin/age "https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz"
sudo tar -xzf /usr/local/bin/age -C /usr/local/bin/

# Add user to docker group
sudo usermod -aG docker ${USER}

echo "Bootstrap complete. Please log out and log back in for docker group changes to take effect."
