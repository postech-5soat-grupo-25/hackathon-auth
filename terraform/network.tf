resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "ecs_subnet_public" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "ecs_subnet_public_2" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ecs_igw" {
  vpc_id = aws_vpc.ecs_vpc.id
}

resource "aws_route_table" "ecs_route_table" {
  vpc_id = aws_vpc.ecs_vpc.id
}

resource "aws_route" "ecs_route" {
  route_table_id         = aws_route_table.ecs_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ecs_igw.id
}

resource "aws_route_table_association" "ecs_route_table_assoc" {
  subnet_id      = aws_subnet.ecs_subnet_public.id
  route_table_id = aws_route_table.ecs_route_table.id
}

resource "aws_route_table_association" "ecs_route_table_assoc_2" {
  subnet_id      = aws_subnet.ecs_subnet_public_2.id
  route_table_id = aws_route_table.ecs_route_table.id
}
