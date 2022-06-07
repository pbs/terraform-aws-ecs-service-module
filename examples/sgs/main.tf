resource "aws_security_group" "mysql_sg" {
  description = "Controls access to ${var.product} mysql resources"
  vpc_id      = data.aws_vpc.vpc.id
  name_prefix = "${var.product}-sg-"

  tags = {
    application = var.product
    environment = var.environment
    creator     = "terraform"
  }
}

resource "aws_security_group_rule" "mysql_egress" {
  security_group_id = aws_security_group.mysql_sg.id
  description       = "Allow all traffic out"
  type              = "egress"
  protocol          = "-1"

  from_port = 0
  to_port   = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "redis_sg" {
  description = "Controls access to ${var.product} redis resources"
  vpc_id      = data.aws_vpc.vpc.id
  name_prefix = "${var.product}-sg-"

  tags = {
    application = var.product
    environment = var.environment
    creator     = "terraform"
  }
}

resource "aws_security_group_rule" "redis_egress" {
  security_group_id = aws_security_group.redis_sg.id
  description       = "Allow all traffic out"
  type              = "egress"
  protocol          = "-1"

  from_port = 0
  to_port   = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "memcached_sg" {
  description = "Controls access to ${var.product} memcached resources"
  vpc_id      = data.aws_vpc.vpc.id
  name_prefix = "${var.product}-sg-"

  tags = {
    application = var.product
    environment = var.environment
    creator     = "terraform"
  }
}

resource "aws_security_group_rule" "memcached_egress" {
  security_group_id = aws_security_group.memcached_sg.id
  description       = "Allow all traffic out"
  type              = "egress"
  protocol          = "-1"

  from_port = 0
  to_port   = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "ingress_sg" {
  description = "Controls access to ${var.product} ingress resources"
  vpc_id      = data.aws_vpc.vpc.id
  name_prefix = "${var.product}-sg-"

  tags = {
    application = var.product
    environment = var.environment
    creator     = "terraform"
  }
}
module "service" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone

  mysql_sg_ids     = [aws_security_group.mysql_sg.id]
  redis_sg_ids     = [aws_security_group.redis_sg.id]
  memcached_sg_ids = [aws_security_group.memcached_sg.id]

  restricted_sg = aws_security_group.ingress_sg.id

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
