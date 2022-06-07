module "service" {
  source = "../.."

  private_hosted_zone = var.private_hosted_zone
  public_service      = false

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
