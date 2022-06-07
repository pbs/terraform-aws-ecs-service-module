module "efs" {
  source = "github.com/pbs/terraform-aws-efs-module?ref=0.0.1"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "service" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone

  efs_mounts = [
    {
      file_system_id = module.efs.id
      efs_path       = "/"
      container_path = "/mnt/efs"
    }
  ]

  efs_sg_ids = module.efs.sgs

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
