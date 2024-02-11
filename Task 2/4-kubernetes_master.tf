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
      "kubeadm token create --print-join-command > /tmp/join_command.txt"
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.kubernetes_master]
}