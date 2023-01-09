resource "aws_instance" "demo_server" {
ami = var.filebeats_ami_id
instance_type = "t3.medium"

  vpc_security_group_ids = [aws_security_group.elk_server_demo.id]
  key_name = "elk_key"
  subnet_id = aws_subnet.private.id


    
  
  
  tags = {
    Name = "demo1"
  }
}