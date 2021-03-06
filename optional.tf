variable "name" {
  description = "Name of the service. Will default to product if not defined."
  default     = null
  type        = string
}

variable "deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment"
  default     = 150
  type        = number
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
  default     = 100
  type        = number
}

variable "container_port" {
  description = "Port the container will expose"
  default     = 80
  type        = number
}

variable "min_capacity" {
  description = "The minimum capacity of tasks for this service"
  default     = 1
  type        = number
}

variable "max_capacity" {
  description = "The maximum capacity of tasks for this service"
  default     = 2
  type        = number
}

variable "prod_min_capacity" {
  description = "Defining a value here will result in a change in min_capacity when environment = prod"
  default     = null
  type        = number
}

variable "prod_max_capacity" {
  description = "Defining a value here will result in a change in min_capacity when environment = prod"
  default     = null
  type        = number
}

variable "scale_up_cooldown" {
  description = "Scale up cooldown in minutes"
  default     = 1
  type        = number
}

variable "scale_up_adjustment" {
  description = "Tasks to add on scale up"
  default     = 2
  type        = number
}

variable "scale_down_cooldown" {
  description = "Scale down cooldown in minutes"
  default     = 5
  type        = number
}

variable "scale_down_adjustment" {
  description = "Tasks to add on scale up"
  default     = -1
  type        = number
}

variable "scaling_evaluation_period" {
  description = "Scaling evaluation period in seconds"
  default     = 60
  type        = number
}

variable "scaling_evaluation_periods" {
  description = "Number of periods over which data is compared to the threshold"
  default     = 1
  type        = number
}

variable "scale_up_cpu_threshold" {
  description = "Threshold at which CPU utilization triggers a scale up event"
  default     = 80
  type        = number
}

variable "scale_down_cpu_threshold" {
  description = "Threshold at which CPU utilization triggers a scale down event"
  default     = 20
  type        = number
}

variable "scale_up_memory_threshold" {
  description = "Threshold at which Memory utilization triggers a scale up event"
  default     = 80
  type        = number
}

variable "scale_down_memory_threshold" {
  description = "Threshold at which Memory utilization triggers a scale down event"
  default     = 20
  type        = number
}

variable "cpu_reservation" {
  description = "CPU reservation for task"
  default     = 256
  type        = number
}

variable "memory_reservation" {
  description = "memory reservation for task"
  default     = 512
  type        = number
}

variable "container_protocol" {
  description = "Protocol to use in connection to the container"
  default     = "HTTP"
  type        = string
}

variable "healthcheck_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 3
  type        = number
}

variable "healthcheck_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  default     = 3
  type        = number
}

variable "healthcheck_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  default     = 6
  type        = number
}

variable "healthcheck_path" {
  description = "The destination for the health check request"
  default     = null
  type        = string
}

variable "healthcheck_protocol" {
  description = "The protocol to use to connect with the target"
  default     = null
  type        = string
}

variable "healthcheck_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  default     = 10
  type        = number
}

variable "healthcheck_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  default     = 200
  type        = number
}
variable "service_healthcheck_healthy_threshold" {
  description = "The number of successful checks before a service is considered healthy"
  default     = 2
  type        = number
}

variable "service_healthcheck_unhealthy_threshold" {
  description = "The number of unsuccessful checks before a service is considered unhealthy"
  default     = 2
  type        = number
}

variable "service_healthcheck_timeout" {
  description = "The time, in milliseconds, before a timeout on the health check of the service"
  default     = 3000
  type        = number
}

variable "service_healthcheck_interval" {
  description = "The time, in milliseconds, between health checks of the service"
  default     = 6000
  type        = number
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  default     = "FARGATE"
  type        = string
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks"
  default     = "SERVICE"
  type        = string
}

variable "platform_version" {
  description = "The platform version on which to run your service"
  default     = "LATEST"
  type        = string
}

variable "restricted_cidr_blocks" {
  description = "CIDR blocks to receive restricted service access. If empty, no CIDRs will be allowed to connect."
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "restricted_sg" {
  description = "SG to receive restricted service access. If null, no sg will be configured to connect"
  default     = null
  type        = string
}

variable "cluster" {
  description = "Name of the ECS Cluster this service runs in. If null, one will be created based on the product"
  default     = null
  type        = string
}

variable "assign_public_ip" {
  description = "Assign public IP to the service"
  default     = true
  type        = bool
}

variable "target_group_name" {
  description = "Target group name. Will default to product if not defined."
  default     = null
  type        = string
}

variable "load_balancer_name" {
  description = "Load balancer name. Will default to product if not defined."
  default     = null
  type        = string
}

variable "aliases" {
  description = "CNAME(s) that are allowed to be used for this service. Default is `product`.`primary_hosted_zone`. e.g. [product.example.com] --> [product.example.com]"
  default     = null
  type        = list(string)
}

variable "cnames" {
  description = "CNAME(s) that are going to be created for this service in the primary_hosted_zone. This can be set to [] to avoid creating a CNAME for the app. This can be useful for CDNs. Default is `product`. e.g. [product] --> [product.example.com]"
  default     = null
  type        = list(string)
}

variable "task_def_arn" {
  description = "Task definition ARN. If null, task will be created with default values, except that image_repo and image_tag may be defined."
  default     = null
  type        = string
}

variable "image_repo" {
  description = "Image repo. e.g. image_repo = nginx --> nginx:image_tag. Ignored if task_def_arn is defined."
  default     = "nginx"
  type        = string
}

variable "image_tag" {
  description = "Tag of the image. e.g. image_tag = latest --> image_repo:latest. Ignored if task_def_arn is defined."
  default     = "alpine"
  type        = string
}

variable "subnets" {
  description = "Subnets for the service. If null, private and public subnets will be looked up based on environment tag and one will be selected based on public_service."
  default     = null
  type        = list(string)
}

variable "public_service" {
  description = "Service should be provisioned in public subnet. Ignored if subnets defined."
  default     = true
  type        = bool
}

variable "internal" {
  description = "Use an internal load balancer. If null, will be internal when the service is private."
  default     = null
  type        = bool
}

variable "vpc_id" {
  description = "VPC ID. If null, one will be looked up based on environment tag."
  default     = null
  type        = string
}

variable "primary_hosted_zone" {
  description = "Name of the primary hosted zone for DNS. e.g. primary_hosted_zone = example.org --> service.example.org. If null, it is assumed that a private hosted zone will be used."
  default     = null
  type        = string
}

variable "private_hosted_zone" {
  description = "Name of the private hosted zone for DNS. e.g. private_hosted_zone = example.org --> service.example.private. If null, it is assumed that a public hosted zone will be used."
  default     = null
  type        = string
}

variable "mysql_sg_ids" {
  description = "MySQL DB Security group IDs"
  default     = []
  type        = set(string)
}

variable "redis_sg_ids" {
  description = "Redis Security group IDs"
  default     = []
  type        = set(string)
}

variable "memcached_sg_ids" {
  description = "Memcached Security group IDs"
  default     = []
  type        = set(string)
}

variable "efs_sg_ids" {
  description = "EFS Security group IDs"
  default     = []
  type        = set(string)
}

variable "load_balancer_type" {
  description = "Type of load balancer to use. alb, nlb or gateway."
  default     = "application"
  type        = string
}

variable "nlb_protocol" {
  description = "Protocol for the network load balancer used in this service. Ignored for application load balancers."
  default     = "TLS"
  type        = string
}

variable "mesh_name" {
  description = "the name for the App Mesh this service is task is associated with. Only populate if this is an envoy service."
  default     = null
  type        = string
}

variable "virtual_gateway" {
  description = "the name of the virtual gateway associated with this task definition. Only populate if this is an envoy service."
  default     = null
  type        = string
}

variable "container_name" {
  description = "name of the primary container for this service. Defaults to local.name if null."
  default     = null
  type        = string
}

variable "role_policy_json" {
  description = "the policy to apply for this service. Defaults to a valid ECS role policy if null."
  default     = null
  type        = string
}

variable "ssm_path" {
  description = "path to the ssm parameters you want pulled into your container during execution of the entrypoint."
  default     = null
  type        = string
}

variable "enable_execute_command" {
  description = "Enables `ecs exec`. If null, will enable if not on prod"
  default     = null
  type        = bool
}

variable "enable_circuit_breaker" {
  description = "Enables ECS circuit breaker"
  default     = true
  type        = bool
}

variable "enable_circuit_breaker_rollback" {
  description = "Enables ECS circuit breaker rollback"
  default     = true
  type        = bool
}

variable "task_family" {
  description = "Name to use for the task family of the task definition associated with this service. By default, uses name."
  default     = null
  type        = string
}

variable "efs_mounts" {
  description = "efs mount map. Components should include dns_name, container_mount_point, efs_mount_point"
  default     = []
  type = list(object({
    file_system_id = string
    efs_path       = string
    container_path = string
  }))
}

variable "env_vars" {
  description = "environment variables to be passed to the container. By default, only passes SSM_PATH"
  default     = null
  type        = list(map(any))
}

variable "newrelic_secret_arn" {
  description = "ARN for AWS Secrets Manager secret of New Relic Insights insert key."
  default     = null
  type        = string
}

variable "newrelic_secret_name" {
  description = "Name for AWS Secrets Manager secret of New Relic Insights insert key."
  default     = null
  type        = string
}

variable "create_lb" {
  description = "Create load balancer for service. If creating a virtual node, will ignore value."
  default     = true
  type        = bool
}

variable "command" {
  description = "command to run in the container as an array. e.g. [\"sleep\", \"10\"]. If null, does not set a command in the task definition."
  default     = null
  type        = list(string)
}

variable "entrypoint" {
  description = "entrypoint to run in the container as an array. e.g. [\"sleep\", \"10\"]. If null, does not set an entrypoint in the task definition."
  default     = null
  type        = list(string)
}

variable "virtual_node" {
  description = "The name of the virtual node associated with this service."
  type        = string
  default     = null
}

variable "virtual_service" {
  description = "The name of the virtual service associated with this ecs service."
  type        = string
  default     = null
}

variable "namespace_id" {
  description = "Namespace ID."
  type        = string
  default     = null
}

variable "namespace" {
  description = "Namespace. If null, defaults to `var.application-tag`."
  default     = null
  type        = string
}
variable "virtual_node_protocol" {
  description = "Protocol for the virtual node"
  default     = "http"
  type        = string
}

variable "dns_evaluate_target_health" {
  description = "evaluate health of endpoints by querying DNS records"
  default     = false
  type        = bool
}

variable "alpn_policy" {
  description = "Name of the Application-Layer Protocol Negotiation (ALPN) policy. Can be set if protocol is TLS. Valid values are HTTP1Only, HTTP2Only, HTTP2Optional, HTTP2Preferred, and None."
  default     = "HTTP2Preferred"
  type        = string
}

variable "alb_ssl_policy" {
  description = "SSL policy to use for an Application Load Balancer application."
  default     = "ELBSecurityPolicy-2016-08"
  type        = string
}

variable "nlb_ssl_policy" {
  description = "SSL policy to use for a Network Load Balancer application."
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  type        = string
}

variable "acm_arn" {
  description = "ARN of the ACM certificate to use for the service. If null, one will be guessed based on the primary hosted zone of the service."
  default     = null
  type        = string
}
