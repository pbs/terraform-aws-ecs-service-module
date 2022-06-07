data "aws_route53_zone" "hosted_zone" {
  count        = local.lookup_hosted_zone ? 1 : 0
  name         = "${local.hosted_zone}."
  private_zone = !var.public_service
}

data "aws_vpc" "vpc" {
  count = var.vpc_id == null ? 1 : 0
  tags = {
    "Name" : "*${var.environment}*"
  }
}

data "aws_subnets" "public_subnets" {
  count = var.subnets == null ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*-public-*"]
  }
}

data "aws_subnets" "private_subnets" {
  count = var.subnets == null ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*-private-*"]
  }
}

data "aws_acm_certificate" "primary_acm_wildcard_cert" {
  count  = local.lookup_primary_acm_wildcard_cert ? 1 : 0
  domain = "*.${var.primary_hosted_zone}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "default_role_policy_json" {
  statement {
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["arn:aws:ecr:${data.aws_region.current.name}:840364872349:repository/aws-appmesh-envoy"]
  }
  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  statement {
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets",
      "xray:GetSamplingStatisticSummaries"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = var.virtual_gateway != null ? { virtual_gateway : var.virtual_gateway } : {}
    content {
      actions   = ["appmesh:StreamAggregatedResources"]
      resources = ["arn:aws:appmesh:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:mesh/${var.mesh_name}/virtualGateway/${var.virtual_gateway}"]
    }
  }
}
