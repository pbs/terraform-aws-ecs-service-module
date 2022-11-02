module "service" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone

  runtime_platform = {
    cpu_architecture = "ARM64"
  }

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
