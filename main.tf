resource "aws_vpc" "this" {
  cidr_block = "10.20.20.0/26"

  enable_dns_support = true

  enable_dns_hostnames = true
  tags = {
    "Name" = "Application-1"
  }
}
resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.0/28"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "Application-1-private-1a"
  }
}
resource "aws_subnet" "private-1d" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.16/28"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "Application-1-private-1d"
  }
}
resource "aws_subnet" "private-1c" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.32/28"
  availability_zone = "us-east-1c"
  tags = {
    "Name" = "Application-1-private-1c"
  }
}
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-route-table"
  }
}
resource "aws_route_table_association" "private-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_route_table_association" "private-1d" {
  subnet_id      = aws_subnet.private-1d.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_route_table_association" "private-1c" {
  subnet_id      = aws_subnet.private-1c.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-gateway"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}