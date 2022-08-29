resource "aws_instance" "Elastic_server" {
ami = var.elasticsearch_ami_id
  instance_type = "t3.medium"

  vpc_security_group_ids = [aws_security_group.elasticsg_server.id]
  key_name = "elk_key"
  subnet_id = aws_subnet.private.id


  
  
  
  tags = {
    Name = "ElasticSearch"
  }
}