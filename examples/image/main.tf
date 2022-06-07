module "service" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone

  image_repo = "nginx"
  image_tag  = "latest"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
