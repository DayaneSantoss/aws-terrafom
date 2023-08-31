resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name  = "vpc-terraform"
    owner = var.tags.owner

  }
}
resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name  = "subnet-public-terraform"
    owner = var.tags.owner
  }
}
resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name  = "subnet-private-terraform"
    owner = var.tags.owner

  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "internet-gateway-terraform"
    owner = var.tags.owner
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name  = "route-table-terraform"
    owner = var.tags.owner
  }
}
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_table_public.id

}
resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_public.id

  tags = {
    Name  = "nat-gateway-terraform"
    owner = var.tags.owner
  }
}
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name  = "route-table-private-terraform"
    owner = var.tags.owner
  }
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_private.id
}
resource "aws_security_group" "security_group_public" {
  name   = "security-group-public"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "security-group-public-terraform"
    owner = var.tags.owner
  }
}
resource "aws_security_group" "security_group_private" {
  name   = "security-group-private"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "security-group-private-terraform"
    owner = var.tags.owner
  }
}
