module "service" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
