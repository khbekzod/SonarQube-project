packer {
  required_plugins {
    amazon = {
      version = " 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }

    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "group2" {
  ami_name      = "my-sonarqube-{{ timestamp }}"
  instance_type = "t2.medium"
  region        = "us-east-1"
  source_ami    = "ami-0bbdd8c17ed981ef9"
  ssh_username = "ubuntu"
  ssh_keypair_name = "ansible-key"
  ssh_private_key_file = "~/.ssh/id_rsa"
  ami_regions = [
    "us-east-1",
  ]
  #   "us-east-2",
  #   "us-west-1",
  #   "us-west-2",
  #   ]
}

build {
  name = "SonarQube-packer"
  sources = [
    "source.amazon-ebs.group2"
  ]

  provisioner "shell" {
    inline = ["sleep 10"]
  }

  provisioner "ansible" {
    playbook_file = "main.yml"
  }
}
