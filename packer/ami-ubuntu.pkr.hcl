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

#elasticsearch
// source "amazon-ebs" "ubuntu" {
//   ami_name                    = "elastic"
//   instance_type               = "t2.small"
//   region                      = "ap-southeast-2"
//   vpc_id                      = "vpc-083de9f0674124d68"
//   subnet_id                   = "subnet-04de77fb6efe23afc"
//   security_group_id           = "sg-0caada355e26967e1"
//   deprecate_at                = "2023-07-29T23:59:59Z"
//   associate_public_ip_address = true

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
//     Name = "elastic"
//   }
// }

// build {
//   name = "elk_packer"

//   sources = [
//     "source.amazon-ebs.ubuntu"
//   ]
//   provisioner "ansible" {
//     playbook_file = "./playbook/elasticsearch.yml"
//   }

// }
source "amazon-ebs" "logstash" {
  ami_name          = "logstash"
  instance_type     = "t2.small"
  region            = "ap-southeast-2"
  vpc_id            = "vpc-083de9f0674124d68"
  subnet_id         = "subnet-04de77fb6efe23afc"
  security_group_id = "sg-0caada355e26967e1"


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


// source "amazon-ebs" "kibana" {
//   ami_name          = "kibana"
//   instance_type     = "t2.small"
//   region            = "ap-southeast-2"
//   vpc_id            = "vpc-083de9f0674124d68"
//   subnet_id         = "subnet-04de77fb6efe23afc"
//   security_group_id = "sg-0caada355e26967e1"

//   source_ami_filter {
//     filters = {
//       name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

//       root-device-type    = "ebs"
//       virtualization-type = "hvm"
//     }
//     most_recent = true
//     owners      = ["099720109477"]
//   }
//   ssh_username = "ubuntu"
//   tags = {
//     "Name" = "kibana-Server"
//   }
//   deprecate_at = timeadd(timestamp(), "8766h")
// }

// build {
//   name = "kibana-packer"

//   sources = [
//     "source.amazon-ebs.kibana"
//   ]
//   provisioner "ansible" {
//     playbook_file = "./playbook/kibana.yml"
//   }
// }