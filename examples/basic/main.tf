module "service" {
  source = "../.."

  hosted_zone = var.hosted_zone

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
