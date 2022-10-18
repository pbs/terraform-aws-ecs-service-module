resource "aws_appmesh_virtual_node" "virtual_node" {
  count     = local.create_virtual_node ? 1 : 0
  name      = var.virtual_node
  mesh_name = var.mesh_name

  spec {
    listener {
      port_mapping {
        port     = var.container_port
        protocol = var.virtual_node_protocol
      }

      health_check {
        protocol            = var.virtual_node_protocol
        path                = local.healthcheck_path
        healthy_threshold   = var.service_healthcheck_healthy_threshold
        unhealthy_threshold = var.service_healthcheck_unhealthy_threshold
        interval_millis     = var.service_healthcheck_interval
        timeout_millis      = var.service_healthcheck_timeout
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = aws_service_discovery_service.service[0].name
        namespace_name = local.namespace
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
      }
    }
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} Virtual Node" },
  )
}
