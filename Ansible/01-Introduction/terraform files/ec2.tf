#resource block
resource "aws_instance" "ubuntu" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  user_data = file("${path.module}/ansible-install-ubuntu.sh")
  key_name = var.my_key

  tags = {
    "Name" = "Ansible-Ubuntu"
  }
}

resource "aws_instance" "rhel" {
  ami = data.aws_ami.rhel.id
  instance_type = var.my_instance_type
  user_data = file("${path.module}/ansible-install-rhel.sh")
  key_name = var.my_key

  tags = {
    "Name" = "Ansible-rhel8"
  }
}

resource "aws_instance" "ubuntu-hosts" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  user_data = file("${path.module}/create_ansible_user.sh")
  key_name = var.my_key
  count = 3
  tags = {
    "Name" = "My-Ubuntu-${count.index}"
    "Type" = "My-Ubuntu-${count.index}"
  }
}
