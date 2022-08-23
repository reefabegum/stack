packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "Elasticsearch" {
  ami_name          = "Elasticsearch"
  instance_type     = "t2.small"
  region            = "ap-southeast-2"
  vpc_id            = "vpc-07a5008b31f4d4987"
  subnet_id         = "subnet-00220f35a51da2f2e"
  security_group_id = "sg-0541ef6427c1b38ce"

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
      "Name" = "elasticsearch-Server"
    }
     deprecate_at = timeadd(timestamp(), "8766h")
}

build {
  name = "elasticsearch-packer"

  sources = [
    "source.amazon-ebs.Elasticsearch"
  ]


    provisioner "ansible" {
      playbook_file = "./playbook/elasticsearch.yml"
    }
}
source "amazon-ebs" "logstash" {
  ami_name          = "logstash"
  instance_type     = "t2.small"
  region            = "ap-southeast-2"
  vpc_id            = "vpc-07a5008b31f4d4987"
  subnet_id         = "subnet-00220f35a51da2f2e"
  security_group_id = "sg-0541ef6427c1b38ce"


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
  instance_type     = "t2.small"
  region            = "ap-southeast-2"
  vpc_id            = "vpc-07a5008b31f4d4987"
  subnet_id         = "subnet-00220f35a51da2f2e"
  security_group_id = "sg-0541ef6427c1b38ce"

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