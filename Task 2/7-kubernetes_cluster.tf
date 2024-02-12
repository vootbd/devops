# an empty resource block
resource "null_resource" "worker1-cluster" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.kubernetes_worker1.public_ip
  }

  # copy the install_kubernates.sh file from your computer to the master node instance 
  provisioner "file" {
    source      = "/tmp/join_command.sh"
    destination = "/tmp/join_command.sh"
  }

  # set permissions and run the install_kubernates.sh file
  provisioner "remote-exec" {
    inline = [
      "sed -i '1i#!/bin/bash' /tmp/join_command.sh",
      "sudo chmod +x /tmp/join_command.sh",
      "sudo sh /tmp/join_command.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.kubernetes_worker1, aws_instance.kubernetes_master, null_resource.master_node]
}

# an empty resource block
resource "null_resource" "worker2-cluster" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/bastion_key.pem")
    host        = aws_instance.kubernetes_worker2.public_ip
  }

  # copy the install_kubernates.sh file from your computer to the master node instance 
  provisioner "file" {
    source      = "/tmp/join_command.sh"
    destination = "/tmp/join_command.sh"
  }

  # set permissions and run the install_kubernates.sh file
  provisioner "remote-exec" {
    inline = [
      "sed -i '1i#!/bin/bash' /tmp/join_command.sh",
      "sudo chmod +x /tmp/join_command.sh",
      "sudo sh /tmp/join_command.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.kubernetes_worker2, aws_instance.kubernetes_master, null_resource.master_node]
}