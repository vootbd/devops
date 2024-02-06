# launch the ec2 instance and install Kubernetes for master node
resource "aws_instance" "kubernetes_master_ec2_instance" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t3a.medium"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Kubernetes Master Node"
  }
}

# an empty resource block
resource "null_resource" "name" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.kubernetes_master_ec2_instance.public_ip
  }

  # copy the install_kubernates_master.sh file from your computer to the master node instance 
  provisioner "file" {
    source      = "install_kubernates_master.sh"
    destination = "/tmp/install_kubernates_master.sh"
  }

  # set permissions and run the install_jenkins.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_kubernates_master.sh",
      "sudo sh /tmp/install_kubernates_master.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]
}

# launch the ec2 instance and install Kubernetes for worker1 node
resource "aws_instance" "kubernetes_worker1_ec2_instance" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Kubernetes Worker1 Node"
  }
}

# launch the ec2 instance and install Kubernetes for worker2 node
resource "aws_instance" "kubernetes_worker2_ec2_instance" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Kubernetes Worker2 Node"
  }
}