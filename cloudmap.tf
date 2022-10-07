resource "aws_service_discovery_service" "service" {
  count        = local.create_cloudmap_service ? 1 : 0
  name         = local.name
  namespace_id = var.namespace_id

  tags = merge(
    local.tags,
    { Name = "${local.name} Cloud Map Service" }
  )
}
