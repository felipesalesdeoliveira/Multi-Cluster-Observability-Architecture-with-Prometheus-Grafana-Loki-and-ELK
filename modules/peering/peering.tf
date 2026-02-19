resource "aws_vpc_peering_connection" "peering" {
  vpc_id      = var.vpc_app_id
  peer_vpc_id = var.vpc_obs_id
  auto_accept = true

  tags = {
    Name = "app-to-obs-peering"
  }
}

# Rotas APP -> OBS
resource "aws_route" "app_to_obs" {
  for_each = toset(var.app_route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.obs_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

# Rotas OBS -> APP
resource "aws_route" "obs_to_app" {
  for_each = toset(var.obs_route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.app_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}
