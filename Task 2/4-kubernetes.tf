# launch the ec2 instance and install Kubernetes for master node
resource "aws_instance" "kubernetes_master_ec2_instance" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Kubernetes Master Node"
  }
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