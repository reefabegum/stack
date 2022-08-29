resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.Bastionsg_server.id]

  key_name = "elk_key"
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true

  tags = {
    Name = "Bastion"
  }
}