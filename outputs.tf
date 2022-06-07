output "name" {
  description = "Name of the service"
  value       = local.name
}

output "service_id" {
  description = "CloudMap Service ID"
  value       = local.cloudmap_service_id
}

output "service_sg" {
  description = "Service security group"
  value       = aws_security_group.service_sg.id
}

output "domain_name" {
  description = "One domain name that will resolve to this service. Might not be a valid alias."
  value       = local.domain_name
}

output "subnets" {
  description = "Subnets used by this service"
  value       = local.subnets
}

output "task_family" {
  description = "Current task family used by this service"
  value       = local.task_family
}

output "task_def_arn" {
  description = "Current task definition ARN used by this service"
  value       = local.task_def_arn
}

output "container_name" {
  description = "Name of the main container used by this service"
  value       = local.container_name
}

output "cluster" {
  description = "Cluster this service is associated with"
  value       = local.cluster
}

output "image_tag" {
  description = "Tag of the image used by this service"
  value       = var.image_tag
}

output "virtual_node_name" {
  description = "Name of the virtual node"
  value       = local.virtual_node_name
}
