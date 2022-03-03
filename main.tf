# vpc-cidr

resource "aws_vpc" "devops-tf" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "devops-tf"
  }
}

# vpc-subnet

resource "aws_subnet" "devops-tf-pub-1" {
  vpc_id     = aws_vpc.devops-tf.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "devops-tf-pub-1"
  }
}

resource "aws_subnet" "devops-tf-pvt-1" {
  vpc_id     = aws_vpc.devops-tf.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "devops-tf-pvt-1"
  }
}
# igw

resource "aws_internet_gateway" "devops-tf-gw" {
  vpc_id = aws_vpc.devops-tf.id

  tags = {
    Name = "devops-tf-igw"
  }
}

#route_table

resource "aws_route_table" "devops-tf-rt" {
  vpc_id = aws_vpc.devops-tf.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_vpc.devops-tf.id
  }

  tags = {
    Name = "devops-tf-rt"
  }
}

# route_table_association

resource "aws_route_table_association" "devops-tf-rta" {
  subnet_id      = devops-tf-pub-1.id
  route_table_id = devops-tf-rt.id
}


