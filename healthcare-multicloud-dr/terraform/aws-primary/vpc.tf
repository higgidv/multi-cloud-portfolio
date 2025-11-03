# Data source for available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Second private data subnet in different AZ
resource "aws_subnet" "private_data_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name        = "Private Data Subnet 2"
    Project     = "Healthcare-DR"
    Environment = "Production"
    Tier        = "Data"
  }
}

# Route table association
resource "aws_route_table_association" "private_data_2" {
  subnet_id      = aws_subnet.private_data_2.id
  route_table_id = aws_route_table.private.id
}