resource "aws_vpc_peering_connection" "vpc-peering" {
  vpc_id      = var.vpc_id_requester
  peer_vpc_id = var.vpc_id_accepter
  auto_accept = true

  tags = {
    Name = "app-to-observability-peering"
  }
}
