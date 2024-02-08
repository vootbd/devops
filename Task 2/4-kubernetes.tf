# launch the ec2 instance and install Kubernetes for master node
resource "aws_instance" "kubernetes_master" {
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
resource "null_resource" "master_node" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.kubernetes_master.public_ip
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
      "sudo sh /tmp/kube_init.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.kubernetes_master]
}

# launch the ec2 instance and install Kubernetes for worker1 node
resource "aws_instance" "kubernetes_worker1" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t3a.medium"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Kubernetes Worker1 Node"
  }
}

# an empty resource block
resource "null_resource" "worker1" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.kubernetes_master.public_ip
  }

  # copy the install_kubernates.sh file from your computer to the master node instance 
  provisioner "file" {
    source      = "install_kubernates.sh"
    destination = "/tmp/install_kubernates.sh"
  }

  # set permissions and run the install_kubernates.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_kubernates.sh",
      "sudo sh /tmp/install_kubernates.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.kubernetes_worker1]
}

# launch the ec2 instance and install Kubernetes for worker2 node
resource "aws_instance" "kubernetes_worker2" {
#  ami                    = data.aws_ami.ubuntu_22_04.id
  ami                    = "ami-008fe2fc65df48dac"
  instance_type          = "t3a.medium"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  key_name               = "bastion_key"
  #user_data              = 

  tags = {
    Name = "Kubernetes Worker2 Node"
  }
}

# an empty resource block
resource "null_resource" "worker2" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.kubernetes_master.public_ip
  }

  # copy the install_kubernates.sh file from your computer to the master node instance 
  provisioner "file" {
    source      = "install_kubernates.sh"
    destination = "/tmp/install_kubernates.sh"
  }

  # set permissions and run the install_kubernates.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_kubernates.sh",
      "sudo sh /tmp/install_kubernates.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.kubernetes_worker2]
}