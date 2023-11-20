module "service" {
  source = "../.."

  hosted_zone            = var.hosted_zone
  public_service         = false
  is_hosted_zone_private = true

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
