resource "aws_instance" "Logstash_server" {
ami = var.logstash_ami_id
  instance_type = "t3.medium"

  vpc_security_group_ids = [aws_security_group.elk_server.id]
  key_name = "elk_key"
  subnet_id = aws_subnet.private.id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  
  
  
  tags = {
    Name = "Logstash"
  }
}