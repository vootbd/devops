#!/bin/bash
sudo sed -i 's/APT::Periodic::Update-Package-Lists "1";/APT::Periodic::Update-Package-Lists "0";/g' /etc/apt/apt.conf.d/20auto-upgrades
sudo sed -i 's/#\$nrconf{verbosity} = '2';/\$nrconf{verbosity} = '0';/g' /etc/needrestart/needrestart.conf
sudo sed -i 's/#\$nrconf{restart} = '\''i'\'';/\$nrconf{restart} = '\''a'\'';/g' /etc/needrestart/needrestart.conf
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install net-tools fontconfig openjdk-17-jre -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

