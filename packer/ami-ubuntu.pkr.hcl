packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}
variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0c56acad970015d39"
}

variable "subnet_id" {
  type    = string
  default = "subnet-07eda576e1a65597c"
}

variable "security_group_id" {
  type    = string
  default = "sg-0d13d7909b502ff78"
}

#elasticsearch
source "amazon-ebs" "ubuntu" {
  ami_name                    = "elastic"
  instance_type               = var.instance_type
  region                      = var.aws_region
  vpc_id                      = var.vpc_id
  subnet_id                   = var.subnet_id
  security_group_id           = var.security_group_id
  deprecate_at                = "2023-07-29T23:59:59Z"
  associate_public_ip_address = true
  force_deregister            = true
  force_delete_snapshot       = true

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    Name = "elastic"
  }
}

build {
  name = "elk_packer"

  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "ansible" {
    playbook_file = "./playbook/elasticsearch.yml"
  }
}

source "amazon-ebs" "logstash" {
  ami_name          = "logstash"
  instance_type     = var.instance_type
  region            = var.aws_region
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id


  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    "Name" = "logstash-Server"
  }
}

build {
  name = "logstash-packer"

  sources = [
    "source.amazon-ebs.logstash"
  ]


  provisioner "ansible" {
    playbook_file = "./playbook/logstash.yml"
  }
}


source "amazon-ebs" "kibana" {
  ami_name          = "kibana"
  instance_type     = var.instance_type
  region            = var.aws_region
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id

  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    "Name" = "kibana-Server"
  }
  deprecate_at = timeadd(timestamp(), "8766h")
}

build { 
  name = "kibana-packer"

  sources = [
    "source.amazon-ebs.kibana"
  ]
  provisioner "ansible" {
    playbook_file = "./playbook/kibana.yml"
  }
}
// source "amazon-ebs" "elk-beats" {
//   ami_name                    = "Filebeats"
//   instance_type               = var.instance_type
//   region                      = var.aws_region
//   vpc_id                      = var.vpc_id
//   subnet_id                   = var.subnet_id
//   security_group_id           = var.security_group_id
//   deprecate_at                = "2023-07-29T23:59:59Z"
//   associate_public_ip_address = true
//   force_deregister            = true
//   force_delete_snapshot       = true

//   source_ami_filter {
//     filters = {
//       name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
//       root-device-type    = "ebs"
//       virtualization-type = "hvm"
//     }
//     most_recent = true
//     owners      = ["099720109477"]
//   }
//   ssh_username = "ubuntu"
//   tags = {
//     Name = "ami-beats"
//   }
// }

// build {
//   name = "packer-demo"
//   sources = [
//     "source.amazon-ebs.elk-beats"
//   ]
//   provisioner "ansible" {
//     playbook_file = "./playbook/filebeats.yml"
//   }
// }