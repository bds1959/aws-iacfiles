provider "aws" {
  region     = "us-west-2"
}
  ingress{
    from_port = 22
    to_port = 22
    cidr_blocks = ["10.0.0.1/16"]
  }
resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress{
    from_port = 22
    to_port = 22
    cidr_blocks = ["10.0.0.1/16"]
  }
    git_commit           = "af437ea563d82ecfe6527683d243ba4d6f1aa563"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-12 04:05:55"
    git_last_modified_by = "murali@banyandata.com"
    git_modifiers        = "murali"
    git_org              = "bds1959"
    git_repo             = "terragoat"
    yor_trace            = "ac29ca85-7ff9-4794-a835-6259d0a4bbb0"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = "ami-090717c950a5c34d3"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "af437ea563d82ecfe6527683d243ba4d6f1aa563"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-12 04:05:55"
    git_last_modified_by = "murali@banyandata.com"
    git_modifiers        = "murali"
    git_org              = "bds1959"
    git_repo             = "terragoat"
    yor_trace            = "0a64290e-f8a7-432e-925f-beb407a5da08"
  }
}