# AWS VPC Creation

resource "aws_vpc" "our-vpc" {
  cidr_block = var.vpc_cidr_value
  tags = {
    Name : "Our-VPC"
    Environment : var.environment
  }
}


# AWS IGW CREATION

resource "aws_internet_gateway" "our-igw" {
  vpc_id = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-IGW"
    Environment : var.environment
  }
}


# AWS SUBNET CREATION

resource "aws_subnet" "our-public-subnet1" {
  vpc_id                  = aws_vpc.our-vpc.id
  cidr_block              = var.public-subnet-cidr-value1
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name : "Our-Public-Subnet1"
    Environment : var.environment
  }
}

resource "aws_subnet" "our-public-subnet2" {
  vpc_id                  = aws_vpc.our-vpc.id
  cidr_block              = var.public-subnet-cidr-value2
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name : "Our-Public-Subnet2"
    Environment : var.environment
  }
}

resource "aws_subnet" "our-private-subnet1" {
  vpc_id                  = aws_vpc.our-vpc.id
  cidr_block              = var.private-subnet-cidr-value1
  map_public_ip_on_launch = false # This is private subnet so no need of public ip
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name : "Our-Private-Subnet1"
    Environment : var.environment
  }
}

resource "aws_subnet" "our-private-subnet2" {
  vpc_id                  = aws_vpc.our-vpc.id
  cidr_block              = var.private-subnet-cidr-value2
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name : "Our-Private-Subnet2"
    Environment : var.environment
  }
}


# AWS ROUTE TABLE CREATION

resource "aws_route_table" "our-public-route-table1" {
  vpc_id = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-Public-Route-Table1"
    Environment : var.environment
  }
}

resource "aws_route_table" "our-public-route-table2" {
  vpc_id = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-Public-Route-Table2"
    Environment : var.environment
  }
}

resource "aws_route_table" "our-private-route-table1" {
  vpc_id = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-Private-Route-Table1"
    Environment : var.environment
  }
}

resource "aws_route_table" "our-private-route-table2" {
  vpc_id = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-Private-Route-Table2"
    Environment : var.environment
  }
}


# AWS SUBNET ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "our-public-route-table-association1" {
  subnet_id      = aws_subnet.our-public-subnet1.id
  route_table_id = aws_route_table.our-public-route-table1.id
}

resource "aws_route_table_association" "our-public-route-table-association2" {
  subnet_id      = aws_subnet.our-public-subnet2.id
  route_table_id = aws_route_table.our-public-route-table2.id
}

resource "aws_route_table_association" "our-private-route-table-association1" {
  subnet_id      = aws_subnet.our-private-subnet1.id
  route_table_id = aws_route_table.our-private-route-table1.id
}

resource "aws_route_table_association" "our-private-route-table-association2" {
  subnet_id      = aws_subnet.our-private-subnet2.id
  route_table_id = aws_route_table.our-private-route-table2.id
}


# AWS ROUTE ADDITION INTO ROUTE TABLES

resource "aws_route" "our-public-route1" {
  route_table_id         = aws_route_table.our-public-route-table1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.our-igw.id
}

resource "aws_route" "our-public-route2" {
  route_table_id         = aws_route_table.our-public-route-table2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.our-igw.id
}



# AWS SECURITY GROUP

resource "aws_security_group" "our-security-group" {
  name        = "Our-Security-Group"
  description = "Our Security Group"
  vpc_id      = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-Security-Group"
    Environment : var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# AWS SECURITY GROUP FOR SONAR SERVER

resource "aws_security_group" "our-Security-Group-for-sonar" {
  name        = "Our-Security-Group-for-sonar"
  description = "Our Security Group"
  vpc_id      = aws_vpc.our-vpc.id
  tags = {
    Name : "Our-Security-Group-for-sonar"
    Environment : var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9000 # This is syntax to open port 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
