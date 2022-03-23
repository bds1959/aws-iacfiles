provider "aws" {
  access_key = "AKIAVRBV6W7"
  secret_key = "aMUSeS49LHiSMaE+"
  region     = "us-east-2"
}

# ec2 instance

resource "aws_key_pair" "murali_tf" {
  key_name   = "murali_tf"
  public_key = "ssh-rsa +/f+nEyDk15hZvSp7CWLjLHNd5BL1ehHc5exM="
}

resource "aws_instance" "web-instance" {
  key_name      = "murali_tf"
  ami           = "ami-013f17f36f8b1fefb"
  instance_type = "t2.micro"
  subnet_id     = "subnet-09763ed91acfb8d36"
  tags = {
    Name = "web-instance"
  }

  vpc_security_group_ids = "sg-0c540cbc66903e8e5"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/b1959/.ssh/id_rsa")
    host        = self.public_ip
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_eip" "web-eip" {
  vpc      = true
  instance = aws_instance.web-instance.id
}

resource "aws_instance" "db-instance" {
  key_name      = "murali_tf"
  ami           = "ami-013f17f36f8b1fefb"
  instance_type = "t2.micro"
  subnet_id     = "subnet-01a7b400b38d4b282"
  tags = {
    Name = "db-instance"
  }

  vpc_security_group_ids = "sg-082bbeff7187b019d"

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}
