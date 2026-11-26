resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = merge(var.vpc_tags, local.tags)
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.igw_tags, local.tags)
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  for_each = local.private_subnet_map
  cidr_block = each.key
  availability_zone = each.value
  tags = merge( var.subnet_tags,
        {
            Name = "${local.env_name}-private-${each.value}"
        } , local.tags)
    

}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  for_each = local.public_subnet_map
  cidr_block = each.key
  availability_zone = each.value
  map_public_ip_on_launch = true
  tags = merge( var.subnet_tags,
        {
            Name = "${local.env_name}-public-${each.value}"
        } , local.tags)
    

}

resource "aws_eip" "main" {
  domain   = "vpc"
  tags = merge(var.eip_tags,local.tags)
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = merge({
    Name = "${local.env_name}-${var.natgw_name}"}, local.tags)

    depends_on = [ aws_internet_gateway.main ]
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = local.tags
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }

  tags = local.tags
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}