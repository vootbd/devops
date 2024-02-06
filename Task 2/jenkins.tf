# use data source to get a registered ubuntu ami
#data "aws_ami" "ubuntu_22_04" {
#  most_recent = true
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-amd64-*"]  # Match Ubuntu 22.04 AMIs
#  }
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]  # Filter for HVM AMIs
#  }
#  owners = ["099720109477"]
#}

# launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Jenkins server"
  }
}

# an empty resource block
resource "null_resource" "jenkins" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.ec2_instance.public_ip
  }

  # copy the install_jenkins.sh file from your computer to the ec2 instance 
  provisioner "file" {
    source      = "install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }

  # set permissions and run the install_jenkins.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_jenkins.sh",
      "sh /tmp/install_jenkins.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]
}


# print the url of the jenkins server
output "website_url" {
  value     = join ("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
}
