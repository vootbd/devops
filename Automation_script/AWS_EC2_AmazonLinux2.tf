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
  #region    = "us-west-2"
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

# create security group for the Jenkins instance
resource "aws_security_group" "AmazonLinux__security_group" {
  name        = "AmazonLinux security group"
  description = "allow access on ports specific ports"
  vpc_id      = aws_default_vpc.default_vpc.id

  # allow access on port 80
  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

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
    Name = "AmazonLinux server security group"
  }
}