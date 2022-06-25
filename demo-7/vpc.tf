# Internet VPC
resource "aws_vpc" "prodvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "prodvpc"
  }
}

# Subnets
resource "aws_subnet" "prodvpc-public-1" {
  vpc_id                  = aws_vpc.prodvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "prodvpc-public-1"
  }
}

resource "aws_subnet" "prodvpc-public-2" {
  vpc_id                  = aws_vpc.prodvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "prodvpc-public-2"
  }
}

resource "aws_subnet" "prodvpc-public-3" {
  vpc_id                  = aws_vpc.prodvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "prodvpc-public-3"
  }
}

resource "aws_subnet" "prodvpc-private-1" {
  vpc_id                  = aws_vpc.prodvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "prodvpc-private-1"
  }
}

resource "aws_subnet" "prodvpc-private-2" {
  vpc_id                  = aws_vpc.prodvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "prodvpc-private-2"
  }
}

resource "aws_subnet" "prodvpc-private-3" {
  vpc_id                  = aws_vpc.prodvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "prodvpc-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "prodvpc-gw" {
  vpc_id = aws_vpc.prodvpc.id

  tags = {
    Name = "prodvpc"
  }
}

# route tables
resource "aws_route_table" "prodvpc-public" {
  vpc_id = aws_vpc.prodvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prodvpc-gw.id
  }

  tags = {
    Name = "prodvpc-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "prodvpc-public-1-a" {
  subnet_id      = aws_subnet.prodvpc-public-1.id
  route_table_id = aws_route_table.prodvpc-public.id
}

resource "aws_route_table_association" "prodvpc-public-2-a" {
  subnet_id      = aws_subnet.prodvpc-public-2.id
  route_table_id = aws_route_table.prodvpc-public.id
}

resource "aws_route_table_association" "prodvpc-public-3-a" {
  subnet_id      = aws_subnet.prodvpc-public-3.id
  route_table_id = aws_route_table.prodvpc-public.id
}

