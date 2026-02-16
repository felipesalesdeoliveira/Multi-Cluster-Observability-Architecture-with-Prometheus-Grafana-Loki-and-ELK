resource "aws_route" "requester_route" {
  route_table_id            = var.requester_route_table_id
  destination_cidr_block    = var.cidr_accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
}

resource "aws_route" "accepter_route" {
  route_table_id            = var.accepter_route_table_id
  destination_cidr_block    = var.cidr_requester
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
}
