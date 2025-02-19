provider "aws" {
  region = "us-east-1"
}


# Create VPC
resource "aws_vpc" "group_1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "group-1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.group_1.id
  tags = {
    Name = "group-1-gw"
  }
}

# Create Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.group_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "group-1-rt"
  }
}

# Create Public Subnets
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.group_1.id19
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = { Name = "group-1-subnet-1" }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.group_1.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = { Name = "group-1-subnet-2" }
}

resource "aws_subnet" "subnet_3" {
  vpc_id                  = aws_vpc.group_1.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = { Name = "group-1-subnet-3" }
}

# Associate Subnets with Route Table
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.rt.id
}
