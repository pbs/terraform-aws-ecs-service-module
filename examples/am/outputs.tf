output "domain_name" {
  value = module.virtual_gateway.domain_name
}

output "service_id_v1" {
  value = module.service_v1.service_id
}

output "service_id_v2" {
  value = module.service_v2.service_id
}
