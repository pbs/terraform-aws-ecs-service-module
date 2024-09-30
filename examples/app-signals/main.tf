module "service" {
  source = "../.."

  hosted_zone = var.hosted_zone

  enable_application_signals = true

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
