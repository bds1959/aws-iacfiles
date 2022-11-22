provider "aws" {
  access_key = "AKIAVCWMH3LZIURBV6W7"
  secret_key = "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"
  region     = "us-east-2"
}

# ec2 instance

resource "aws_key_pair" "murali_tf" {
  key_name   = "murali_tf"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDl33U29vYdzcx9uw3ZZ0jO2Elr7W0GkoUo3faIxcWORqqoJZ1OYNzRgfEpVqdMyLz8MLjXIufnsV+FEFOHV3/fO7foNjLJXgu2QCQmLM+1igRbxRiUPxTjgIuoYMnIT3wm1G0B6owrI4CFRDo3oB0vd9W6OzETv0zNpduUBBzHHqHIdu4sb4jsfsvlr3RPmLd4KY+q03+6He70pjh9Eguroxh6+kPeZxF5jQlaNjnPQXGsc9UEUviJiDbkD3hA0CM3MM7zSjktJL2X3kBGMYqLqQ9lPAx2AXZdMC8YYlBqcgHC9GF5ny5LwBw44/16Agqf8fksV3Vx+OcDMaW14B6w4FhZLjm118GBbUj6ECL1i8dzeBcLzex5WijAp++fTSxxGIMpHpWt3ATjFSDeAr1u4aiJAa9vwJ/nOglqNFd7T2KP3FGEw7jQTlzvU1aguYuCRHWTDlVFHT4bMpGbdive8xbmoZbly+nEyDk15hZvSp7CWLjLHNd5BL1ehHc5exM= b1959@bdsblrwkstn024"
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

