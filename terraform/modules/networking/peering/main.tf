resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.vpc_id_requester
  peer_vpc_id   = var.vpc_id_accepter
  auto_accept   = true

  tags = var.tags
}

# Rota do requester para accepter
resource "aws_route" "requester_to_accepter" {
  route_table_id         = var.requester_route_table_id
  destination_cidr_block = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Rota do accepter para requester
resource "aws_route" "accepter_to_requester" {
  route_table_id         = var.accepter_route_table_id
  destination_cidr_block = var.requester_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
