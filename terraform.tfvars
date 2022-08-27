vpc_name     = "elk_vpc"
aws_region   = "ap-southeast-2"
vpc_cidr     = "192.168.0.0/16"
cidr_public  = "192.168.1.0/24"
cidr_private = "192.168.2.0/24"
cidr_private1  = "192.168.3.0/24"
cidr_private2 = "192.168.4.0/24"
cidr_private3 = "192.168.5.0/24"

elasticsearch_ami_id  = "ami-005f94f736779a626"  
logstash_ami_id = "ami-094732713377d0dce"
kibana_ami_id = "ami-0439f7d2d98f288ff"