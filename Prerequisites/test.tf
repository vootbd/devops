terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.33"
    }
  }
}

# configured aws provider with proper credentials
provider "aws" {
  profile   = "default"
}


# create default vpc if one does not exit
resource "aws_default_vpc" "default_vpc" {

  tags    = {
    Name  = "default vpc"
  }
}


# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# create default subnet if one does not exit
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags   = {
    Name = "default subnet"
  }
}


# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on port 22"
  vpc_id      = aws_default_vpc.default_vpc.id

  # allow access on port 22
  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Test server security group"
  }
}

# launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Test server"
  }
}

# an empty resource block
resource "null_resource" "name" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.ec2_instance.public_ip
  }

  # copy the install_kubernates.sh file from your computer to the master node instance 
  provisioner "file" {
    source      = "install_kubernates.sh"
    destination = "/tmp/install_kubernates.sh"
  }

  provisioner "file" {
    source      = "kube_init.sh"
    destination = "/tmp/kube_init.sh"
  }

  # set permissions and run the install_kubernates.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x -R /tmp/",
      "sudo sh /tmp/install_kubernates.sh",
      "sudo kubeadm init",
      "sh /tmp/kube_init.sh",
      "sudo kubeadm token create --print-join-command > /tmp/join_command.sh",
    ]
  }

  provisioner "local-exec" {
    command = "yes | scp -i /home/ubuntu/bastion_key.pem ubuntu@${aws_instance.kubernetes_master.public_ip}:/tmp/join_command.sh /tmp/"
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]
}