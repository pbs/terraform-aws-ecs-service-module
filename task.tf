module "task" {
  count  = var.task_def_arn == null ? 1 : 0
  source = "github.com/pbs/terraform-aws-ecs-task-definition-module?ref=0.1.0"

  name = local.name

  image_repo = var.image_repo
  image_tag  = var.image_tag

  command    = var.command
  entrypoint = var.entrypoint

  mesh_name       = var.mesh_name
  virtual_gateway = var.virtual_gateway

  role_policy_json = var.role_policy_json

  service_name   = local.name
  task_family    = local.task_family
  container_name = var.container_name
  container_port = var.container_port

  cpu_reservation    = var.cpu_reservation
  memory_reservation = var.memory_reservation

  virtual_node = var.virtual_node

  ssm_path = var.ssm_path
  env_vars = var.env_vars

  efs_mounts = var.efs_mounts

  newrelic_secret_arn  = var.newrelic_secret_arn
  newrelic_secret_name = var.newrelic_secret_name

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
