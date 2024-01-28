#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
#echo -e '\n'   # Enter
#echo -e '\t'   # Tab
#echo -e '\n'   # Enter
sudo apt install openjdk-17-jre -y
#echo -e '\n'   # Enter
#echo -e '\t'   # Tab
#echo -e '\n'   # Enter
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null 
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install jenkins -y
#echo -e '\n'   # Enter
#echo -e '\t'   # Tab
#echo -e '\n'   # Enter
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
