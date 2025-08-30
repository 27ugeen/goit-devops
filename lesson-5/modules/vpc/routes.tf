# Internet Gateway для виходу в інтернет з публічних підмереж
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Одна публічна таблиця маршрутів з дефолтним шляхом на IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Прив’язуємо кожну публічну підмережу до публічної таблиці маршрутів
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# EIP для кожного NAT (по одному в кожній AZ)
resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  domain   = "vpc"

  tags = {
    Name = "${var.vpc_name}-nat-eip-${each.key}"
  }
}

# NAT Gateway у кожній публічній підмережі (по одному на AZ)
resource "aws_nat_gateway" "this" {
  for_each      = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = "${var.vpc_name}-nat-${each.key}"
  }

  depends_on = [aws_internet_gateway.this]
}

# Приватні таблиці маршрутів: кожна приватна підмережа -> NAT у тій же AZ (за індексом)
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[each.key].id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt-${each.key}"
  }
}

# Прив’язуємо кожну приватну підмережу до своєї приватної RT
resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}