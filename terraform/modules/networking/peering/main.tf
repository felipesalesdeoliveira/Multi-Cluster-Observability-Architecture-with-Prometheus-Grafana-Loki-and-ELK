resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true

  tags = {
    Name = "vpc-peering"
  }
}

resource "aws_route" "origin_to_peer" {
  for_each = toset(var.route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.peer_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "peer_to_origin" {
  for_each = toset(var.peer_route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
