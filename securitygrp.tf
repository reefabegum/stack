 #elasticsearch
resource "aws_security_group" "elasticsg_server" {
  name        = "elasticsg-server"
  description = "Allow elk server inbound traffic"
  vpc_id      = aws_vpc.elk_vpc.id
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.103/32"] #private ip of bstion host

  }
  ingress {
    description      = "Allow port 9200"
    from_port        = 9200
    to_port          = 9200
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.103/32"] #private ip of bstion host
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  }
  #logstash
resource "aws_security_group" "logstashsg_server" {
  name        = "logstashsg-server"
  description = "Allow logstash server inbound traffic"
  vpc_id      = aws_vpc.elk_vpc.id
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.103/32"] #private ip of bstion host

  }
  ingress {
    description      = "Allow port 5044"
    from_port        = 5043
    to_port          = 5044
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.103/32"] #private ip of bstion host
  }
  ingress {
    description      = "Allow port 5066"
    from_port        = 5066
    to_port          = 5066
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.103/32"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  }
  # kibana
resource "aws_security_group" "kibanasg_server" {
  name        = "Kinbanasg-server"
  description = "Allow Kibana server inbound traffic"
  vpc_id      = aws_vpc.elk_vpc.id
    ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["157.50.4.192/32"]
  }

  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["157.50.4.192/32"]

  }
  ingress {
    description      = "Allow port 5601"
    from_port        = 5601
    to_port          = 5601
    protocol         = "tcp"
    cidr_blocks      = ["157.50.4.192/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  }
  # bastion
resource "aws_security_group" "Bastionsg_server" {
  name        = "Bastionsg-server"
  description = "Allow Bastion server inbound traffic"
  vpc_id      = aws_vpc.elk_vpc.id
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["157.50.4.192/32"]
  }
      ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["157.50.4.192/32"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  }
resource "aws_security_group" "elk_server_demo" {
  name        = "elk-server-demo"
  description = "Allow elk server inbound traffic"
  vpc_id      = aws_vpc.elk_vpc.id
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "Allow port 5044"
    from_port        = 5044
    to_port          = 5044
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Allow port 5066"
    from_port        = 5066
    to_port          = 5066
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "sg_pckr" {
  name        = "packer"
  description = "Allow packer server inbound traffic"
  vpc_id      = aws_vpc.elk_vpc.id
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
   
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 }