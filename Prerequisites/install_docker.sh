#!/bin/bash

# 1. Uninstall any existing conflicting packages
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# 2. Install necessary dependencies
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 3. Add Docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 4. Add Docker's official repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Update package lists and install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# 6. Test Docker installation
sudo docker run hello-world

# 7. Manage Docker as a non-root user (optional)
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker  # Effective for the current session

# 8. Enable Docker to start at boot
sudo systemctl enable docker