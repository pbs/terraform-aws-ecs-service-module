module "service" {
  source = "../.."

  create_lb = false

  image_repo = "busybox"
  image_tag  = "latest"

  command = ["echo", "hello"]

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
