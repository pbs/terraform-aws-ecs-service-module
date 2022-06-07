resource "aws_security_group" "lb_sg" {
  count       = local.create_lb_security_group ? 1 : 0
  description = "Controls access to the ${local.name} load balancer"

  vpc_id      = local.vpc_id
  name_prefix = "${local.load_balancer_name}-sg-"

  tags = merge(
    local.tags,
    { Name = "${local.name} LB SG" },
  )
}

resource "aws_security_group_rule" "lb_egress" {
  count             = local.create_lb_security_group ? 1 : 0
  security_group_id = aws_security_group.lb_sg[0].id
  description       = "Allow all traffic out"
  type              = "egress"
  protocol          = "-1"

  from_port = 0
  to_port   = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "user_to_lb_http_cidrs" {
  count             = local.create_lb_security_group && local.create_cidr_access_rule ? 1 : 0
  security_group_id = aws_security_group.lb_sg[0].id
  description       = "Allow HTTP traffic from the user to the lb for specific CIDRs"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.http_port
  to_port   = local.http_port

  cidr_blocks = var.restricted_cidr_blocks
}

resource "aws_security_group_rule" "user_to_lb_http_sgs" {
  count             = local.create_lb_security_group && local.create_sg_access_rule ? 1 : 0
  security_group_id = aws_security_group.lb_sg[0].id
  description       = "Allow HTTP traffic from the user to the lb for specific SGs"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.http_port
  to_port   = local.http_port

  source_security_group_id = var.restricted_sg
}

resource "aws_security_group_rule" "user_to_lb_https_cidrs" {
  count             = local.create_lb_security_group && local.create_cidr_access_rule ? 1 : 0
  security_group_id = aws_security_group.lb_sg[0].id
  description       = "Allow HTTPS traffic from the user to the lb"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.https_port
  to_port   = local.https_port

  cidr_blocks = var.restricted_cidr_blocks
}

resource "aws_security_group_rule" "user_to_lb_https_sgs" {
  count             = local.create_lb_security_group && local.create_sg_access_rule ? 1 : 0
  security_group_id = aws_security_group.lb_sg[0].id
  description       = "Allow HTTPS traffic from the user to the lb"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.https_port
  to_port   = local.https_port

  source_security_group_id = var.restricted_sg
}

resource "aws_security_group" "service_sg" {
  description = "Controls access to the ${local.name} service resources"
  vpc_id      = local.vpc_id
  name_prefix = "${local.name}-service-sg-"

  tags = merge(
    local.tags,
    { Name = "${local.name} Service SG" },
  )
}

## Allow All Traffic out anywhere for egress
resource "aws_security_group_rule" "service_egress" {
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow all traffic out"
  type              = "egress"
  protocol          = "-1"

  from_port = 0
  to_port   = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "lb_to_service" {
  count             = local.create_lb_security_group ? 1 : 0
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow container port traffic from the lb to the ECS service"
  type              = "ingress"
  protocol          = "tcp"

  from_port = var.container_port
  to_port   = var.container_port

  source_security_group_id = aws_security_group.lb_sg[0].id
}

resource "aws_security_group_rule" "service_to_lb" {
  count             = local.create_lb_security_group ? 1 : 0
  security_group_id = aws_security_group.lb_sg[0].id
  description       = "Allow container port traffic from the ECS service to the lb"
  type              = "ingress"
  protocol          = "tcp"

  from_port = var.container_port
  to_port   = var.container_port

  source_security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "service_to_mysql" {
  for_each          = var.mysql_sg_ids
  security_group_id = each.value
  description       = "Allow MySQL traffic from the ECS service to the DB"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.mysql_port
  to_port   = local.mysql_port

  source_security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "service_to_redis" {
  for_each          = var.redis_sg_ids
  security_group_id = each.value
  description       = "Allow Redis traffic from the ECS service to the cluster"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.redis_port
  to_port   = local.redis_port

  source_security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "service_to_memcached" {
  for_each          = var.memcached_sg_ids
  security_group_id = each.value
  description       = "Allow Memcached traffic from the ECS service to the cluster"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.memcached_port
  to_port   = local.memcached_port

  source_security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "mysql_to_service" {
  for_each          = var.mysql_sg_ids
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow MySQL traffic from the DB to the service"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.mysql_port
  to_port   = local.mysql_port

  source_security_group_id = each.value
}

resource "aws_security_group_rule" "redis_to_service" {
  for_each          = var.redis_sg_ids
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow Redis traffic from the cluster to the ECS service"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.redis_port
  to_port   = local.redis_port

  source_security_group_id = each.value
}

resource "aws_security_group_rule" "memcached_to_service" {
  for_each          = var.memcached_sg_ids
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow Memcached traffic from the cluster to the ECS service"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.memcached_port
  to_port   = local.memcached_port

  source_security_group_id = each.value
}

resource "aws_security_group_rule" "nlb_service_access_cidr" {
  count             = local.create_nlb_cidr_access_rule ? 1 : 0
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow container port traffic to the ECS service for specific CIDR blocks"
  type              = "ingress"
  protocol          = "tcp"

  from_port = var.container_port
  to_port   = var.container_port

  cidr_blocks = var.restricted_cidr_blocks
}

resource "aws_security_group_rule" "nlb_service_access_sg" {
  count             = local.create_nlb_sg_access_rule ? 1 : 0
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow container port traffic to the ECS service for specific SGs"
  type              = "ingress"
  protocol          = "tcp"

  from_port = var.container_port
  to_port   = var.container_port

  source_security_group_id = var.restricted_sg
}

resource "aws_security_group_rule" "service_to_efs" {
  for_each          = var.efs_sg_ids
  security_group_id = each.value
  description       = "Allow EFS traffic from the ECS service to the EFS"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.efs_port
  to_port   = local.efs_port

  source_security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "efs_service_access_sg" {
  for_each          = var.efs_sg_ids
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow EFS port traffic to the ECS service for specific SGs"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.efs_port
  to_port   = local.efs_port

  source_security_group_id = each.value
}

resource "aws_security_group_rule" "user_to_virtual_node_access_cidr" {
  count             = local.create_virtual_node_cidr_access_rule ? 1 : 0
  description       = "Allow container port traffic to the ECS service for CIDR block"
  security_group_id = aws_security_group.service_sg.id
  type              = "ingress"
  protocol          = "tcp"

  from_port = var.container_port
  to_port   = var.container_port

  cidr_blocks = var.restricted_cidr_blocks
}

resource "aws_security_group_rule" "user_to_virtual_node_access_sg" {
  count             = local.create_virtual_node_sg_access_rule ? 1 : 0
  security_group_id = aws_security_group.service_sg.id
  description       = "Allow container port traffic to the ECS service for specific SGs"
  type              = "ingress"
  protocol          = "tcp"

  from_port = var.container_port
  to_port   = var.container_port

  source_security_group_id = var.restricted_sg
}
