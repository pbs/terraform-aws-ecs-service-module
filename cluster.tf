module "cluster" {
  count  = var.cluster == null ? 1 : 0
  source = "github.com/pbs/terraform-aws-ecs-cluster-module?ref=0.0.4"

  vpc_id = local.vpc_id

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
