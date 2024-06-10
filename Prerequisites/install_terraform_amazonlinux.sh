#!/bin/bash

# Update package lists
sudo yum update -y

# Install package manager for adding repositories (if not already installed)
if ! rpm -q yum-utils &> /dev/null; then
  sudo yum install -y yum-utils
fi

# Add the HashiCorp repository for Amazon Linux
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Update package lists again to include the new repository
sudo yum update -y

# Install the latest Terraform version
sudo yum install -y terraform

# Verify installation by checking the version
terraform --version

echo "Terraform installation complete!"
