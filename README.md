# PBS TF ecs service module

## Installation

### Using the Repo Source

```hcl
github.com/pbs/terraform-aws-ecs-service-module?ref=0.1.0
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions a basic ECS service. Provide the `image_repo` and `image_tag` corresponding to the Docker image you would like to run, and everything from the ECS task definition to the DNS for the load balancer will be provisioned so that you can access your application.

To make the service provisioned here private, set `public_service` to `false`. This will set up a DNS entry in a private hosted zone, and adjust the load balancer associated with the service such that it is an internal load balancer.

To switch the kind of load balancer used from an application load balancer to a network load balancer, set `load_balancer_type` to `network`.

Integrate this module like so:

```hcl
module "ecs-service" {
  source = "github.com/pbs/terraform-aws-ecs-service-module?ref=0.1.0"

  # Required
  primary_hosted_zone = "example.com"

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional
  image_repo = "nginx"
  image_tag = "latest"
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`0.1.0`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | github.com/pbs/terraform-aws-ecs-cluster-module | 0.0.1 |
| <a name="module_task"></a> [task](#module\_task) | github.com/pbs/terraform-aws-ecs-task-definition-module | 0.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.scale_down_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.scale_up_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.autoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appmesh_virtual_node.virtual_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appmesh_virtual_node) | resource |
| [aws_cloudwatch_metric_alarm.cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.memory_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.memory_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.http_redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.http_application_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.https_application_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.service_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.efs_service_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_to_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.memcached_to_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mysql_to_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nlb_service_access_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nlb_service_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.redis_to_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_to_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_to_memcached](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_to_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_to_redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_to_lb_http_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_to_lb_http_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_to_lb_https_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_to_lb_https_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_to_virtual_node_access_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_to_virtual_node_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_service_discovery_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_acm_certificate.primary_acm_wildcard_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.default_role_policy_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnets.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (sharedtools, dev, staging, prod) | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization using this module. Used to prefix tags so that they are easily identified as being from your organization | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Tag used to group resources according to product | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | Tag used to point to the repo using this module | `string` | n/a | yes |
| <a name="input_acm_arn"></a> [acm\_arn](#input\_acm\_arn) | ARN of the ACM certificate to use for the service. If null, one will be guessed based on the primary hosted zone of the service. | `string` | `null` | no |
| <a name="input_alb_ssl_policy"></a> [alb\_ssl\_policy](#input\_alb\_ssl\_policy) | SSL policy to use for an Application Load Balancer application. | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | CNAME(s) that are allowed to be used for this service. Default is `product`.`primary_hosted_zone`. e.g. [product.example.com] --> [product.example.com] | `list(string)` | `null` | no |
| <a name="input_alpn_policy"></a> [alpn\_policy](#input\_alpn\_policy) | Name of the Application-Layer Protocol Negotiation (ALPN) policy. Can be set if protocol is TLS. Valid values are HTTP1Only, HTTP2Only, HTTP2Optional, HTTP2Preferred, and None. | `string` | `"HTTP2Preferred"` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign public IP to the service | `bool` | `true` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Name of the ECS Cluster this service runs in. If null, one will be created based on the product | `string` | `null` | no |
| <a name="input_cnames"></a> [cnames](#input\_cnames) | CNAME(s) that are going to be created for this service in the primary\_hosted\_zone. This can be set to [] to avoid creating a CNAME for the app. This can be useful for CDNs. Default is `product`. e.g. [product] --> [product.example.com] | `list(string)` | `null` | no |
| <a name="input_command"></a> [command](#input\_command) | command to run in the container as an array. e.g. ["sleep", "10"]. If null, does not set a command in the task definition. | `list(string)` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | name of the primary container for this service. Defaults to local.name if null. | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port the container will expose | `number` | `80` | no |
| <a name="input_container_protocol"></a> [container\_protocol](#input\_container\_protocol) | Protocol to use in connection to the container | `string` | `"HTTP"` | no |
| <a name="input_cpu_reservation"></a> [cpu\_reservation](#input\_cpu\_reservation) | CPU reservation for task | `number` | `256` | no |
| <a name="input_create_lb"></a> [create\_lb](#input\_create\_lb) | Create load balancer for service. If creating a virtual node, will ignore value. | `bool` | `true` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment | `number` | `150` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment | `number` | `100` | no |
| <a name="input_dns_evaluate_target_health"></a> [dns\_evaluate\_target\_health](#input\_dns\_evaluate\_target\_health) | evaluate health of endpoints by querying DNS records | `bool` | `false` | no |
| <a name="input_efs_mounts"></a> [efs\_mounts](#input\_efs\_mounts) | efs mount map. Components should include dns\_name, container\_mount\_point, efs\_mount\_point | <pre>list(object({<br>    file_system_id = string<br>    efs_path       = string<br>    container_path = string<br>  }))</pre> | `[]` | no |
| <a name="input_efs_sg_ids"></a> [efs\_sg\_ids](#input\_efs\_sg\_ids) | EFS Security group IDs | `set(string)` | `[]` | no |
| <a name="input_enable_circuit_breaker"></a> [enable\_circuit\_breaker](#input\_enable\_circuit\_breaker) | Enables ECS circuit breaker | `bool` | `true` | no |
| <a name="input_enable_circuit_breaker_rollback"></a> [enable\_circuit\_breaker\_rollback](#input\_enable\_circuit\_breaker\_rollback) | Enables ECS circuit breaker rollback | `bool` | `true` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Enables `ecs exec`. If null, will enable if not on prod | `bool` | `null` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | entrypoint to run in the container as an array. e.g. ["sleep", "10"]. If null, does not set an entrypoint in the task definition. | `list(string)` | `null` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | environment variables to be passed to the container. By default, only passes SSM\_PATH | `list(map(any))` | `null` | no |
| <a name="input_healthcheck_healthy_threshold"></a> [healthcheck\_healthy\_threshold](#input\_healthcheck\_healthy\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `3` | no |
| <a name="input_healthcheck_interval"></a> [healthcheck\_interval](#input\_healthcheck\_interval) | The approximate amount of time, in seconds, between health checks of an individual target | `number` | `10` | no |
| <a name="input_healthcheck_matcher"></a> [healthcheck\_matcher](#input\_healthcheck\_matcher) | The HTTP codes to use when checking for a successful response from a target | `number` | `200` | no |
| <a name="input_healthcheck_path"></a> [healthcheck\_path](#input\_healthcheck\_path) | The destination for the health check request | `string` | `null` | no |
| <a name="input_healthcheck_protocol"></a> [healthcheck\_protocol](#input\_healthcheck\_protocol) | The protocol to use to connect with the target | `string` | `null` | no |
| <a name="input_healthcheck_timeout"></a> [healthcheck\_timeout](#input\_healthcheck\_timeout) | The amount of time, in seconds, during which no response means a failed health check | `number` | `6` | no |
| <a name="input_healthcheck_unhealthy_threshold"></a> [healthcheck\_unhealthy\_threshold](#input\_healthcheck\_unhealthy\_threshold) | The number of consecutive health check failures required before considering the target unhealthy | `number` | `3` | no |
| <a name="input_image_repo"></a> [image\_repo](#input\_image\_repo) | Image repo. e.g. image\_repo = nginx --> nginx:image\_tag. Ignored if task\_def\_arn is defined. | `string` | `"nginx"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Tag of the image. e.g. image\_tag = latest --> image\_repo:latest. Ignored if task\_def\_arn is defined. | `string` | `"alpine"` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Use an internal load balancer. If null, will be internal when the service is private. | `bool` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service | `string` | `"FARGATE"` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | Load balancer name. Will default to product if not defined. | `string` | `null` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Type of load balancer to use. alb, nlb or gateway. | `string` | `"application"` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | The maximum capacity of tasks for this service | `number` | `2` | no |
| <a name="input_memcached_sg_ids"></a> [memcached\_sg\_ids](#input\_memcached\_sg\_ids) | Memcached Security group IDs | `set(string)` | `[]` | no |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | memory reservation for task | `number` | `512` | no |
| <a name="input_mesh_name"></a> [mesh\_name](#input\_mesh\_name) | the name for the App Mesh this service is task is associated with. Only populate if this is an envoy service. | `string` | `null` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | The minimum capacity of tasks for this service | `number` | `1` | no |
| <a name="input_mysql_sg_ids"></a> [mysql\_sg\_ids](#input\_mysql\_sg\_ids) | MySQL DB Security group IDs | `set(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the service. Will default to product if not defined. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace. If null, defaults to `var.application-tag`. | `string` | `null` | no |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | Namespace ID. | `string` | `null` | no |
| <a name="input_newrelic_secret_arn"></a> [newrelic\_secret\_arn](#input\_newrelic\_secret\_arn) | ARN for AWS Secrets Manager secret of New Relic Insights insert key. | `string` | `null` | no |
| <a name="input_newrelic_secret_name"></a> [newrelic\_secret\_name](#input\_newrelic\_secret\_name) | Name for AWS Secrets Manager secret of New Relic Insights insert key. | `string` | `null` | no |
| <a name="input_nlb_protocol"></a> [nlb\_protocol](#input\_nlb\_protocol) | Protocol for the network load balancer used in this service. Ignored for application load balancers. | `string` | `"TLS"` | no |
| <a name="input_nlb_ssl_policy"></a> [nlb\_ssl\_policy](#input\_nlb\_ssl\_policy) | SSL policy to use for a Network Load Balancer application. | `string` | `"ELBSecurityPolicy-TLS13-1-2-2021-06"` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | The platform version on which to run your service | `string` | `"LATEST"` | no |
| <a name="input_primary_hosted_zone"></a> [primary\_hosted\_zone](#input\_primary\_hosted\_zone) | Name of the primary hosted zone for DNS. e.g. primary\_hosted\_zone = example.org --> service.example.org. If null, it is assumed that a private hosted zone will be used. | `string` | `null` | no |
| <a name="input_private_hosted_zone"></a> [private\_hosted\_zone](#input\_private\_hosted\_zone) | Name of the private hosted zone for DNS. e.g. private\_hosted\_zone = example.org --> service.example.private. If null, it is assumed that a public hosted zone will be used. | `string` | `null` | no |
| <a name="input_prod_max_capacity"></a> [prod\_max\_capacity](#input\_prod\_max\_capacity) | Defining a value here will result in a change in min\_capacity when environment = prod | `number` | `null` | no |
| <a name="input_prod_min_capacity"></a> [prod\_min\_capacity](#input\_prod\_min\_capacity) | Defining a value here will result in a change in min\_capacity when environment = prod | `number` | `null` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Specifies whether to propagate the tags from the task definition or the service to the tasks | `string` | `"SERVICE"` | no |
| <a name="input_public_service"></a> [public\_service](#input\_public\_service) | Service should be provisioned in public subnet. Ignored if subnets defined. | `bool` | `true` | no |
| <a name="input_redis_sg_ids"></a> [redis\_sg\_ids](#input\_redis\_sg\_ids) | Redis Security group IDs | `set(string)` | `[]` | no |
| <a name="input_restricted_cidr_blocks"></a> [restricted\_cidr\_blocks](#input\_restricted\_cidr\_blocks) | CIDR blocks to receive restricted service access. If empty, no CIDRs will be allowed to connect. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_restricted_sg"></a> [restricted\_sg](#input\_restricted\_sg) | SG to receive restricted service access. If null, no sg will be configured to connect | `string` | `null` | no |
| <a name="input_role_policy_json"></a> [role\_policy\_json](#input\_role\_policy\_json) | the policy to apply for this service. Defaults to a valid ECS role policy if null. | `string` | `null` | no |
| <a name="input_scale_down_adjustment"></a> [scale\_down\_adjustment](#input\_scale\_down\_adjustment) | Tasks to add on scale up | `number` | `-1` | no |
| <a name="input_scale_down_cooldown"></a> [scale\_down\_cooldown](#input\_scale\_down\_cooldown) | Scale down cooldown in minutes | `number` | `5` | no |
| <a name="input_scale_down_cpu_threshold"></a> [scale\_down\_cpu\_threshold](#input\_scale\_down\_cpu\_threshold) | Threshold at which CPU utilization triggers a scale down event | `number` | `20` | no |
| <a name="input_scale_down_memory_threshold"></a> [scale\_down\_memory\_threshold](#input\_scale\_down\_memory\_threshold) | Threshold at which Memory utilization triggers a scale down event | `number` | `20` | no |
| <a name="input_scale_up_adjustment"></a> [scale\_up\_adjustment](#input\_scale\_up\_adjustment) | Tasks to add on scale up | `number` | `2` | no |
| <a name="input_scale_up_cooldown"></a> [scale\_up\_cooldown](#input\_scale\_up\_cooldown) | Scale up cooldown in minutes | `number` | `1` | no |
| <a name="input_scale_up_cpu_threshold"></a> [scale\_up\_cpu\_threshold](#input\_scale\_up\_cpu\_threshold) | Threshold at which CPU utilization triggers a scale up event | `number` | `80` | no |
| <a name="input_scale_up_memory_threshold"></a> [scale\_up\_memory\_threshold](#input\_scale\_up\_memory\_threshold) | Threshold at which Memory utilization triggers a scale up event | `number` | `80` | no |
| <a name="input_scaling_evaluation_period"></a> [scaling\_evaluation\_period](#input\_scaling\_evaluation\_period) | Scaling evaluation period in seconds | `number` | `60` | no |
| <a name="input_scaling_evaluation_periods"></a> [scaling\_evaluation\_periods](#input\_scaling\_evaluation\_periods) | Number of periods over which data is compared to the threshold | `number` | `1` | no |
| <a name="input_service_healthcheck_healthy_threshold"></a> [service\_healthcheck\_healthy\_threshold](#input\_service\_healthcheck\_healthy\_threshold) | The number of successful checks before a service is considered healthy | `number` | `2` | no |
| <a name="input_service_healthcheck_interval"></a> [service\_healthcheck\_interval](#input\_service\_healthcheck\_interval) | The time, in milliseconds, between health checks of the service | `number` | `6000` | no |
| <a name="input_service_healthcheck_timeout"></a> [service\_healthcheck\_timeout](#input\_service\_healthcheck\_timeout) | The time, in milliseconds, before a timeout on the health check of the service | `number` | `3000` | no |
| <a name="input_service_healthcheck_unhealthy_threshold"></a> [service\_healthcheck\_unhealthy\_threshold](#input\_service\_healthcheck\_unhealthy\_threshold) | The number of unsuccessful checks before a service is considered unhealthy | `number` | `2` | no |
| <a name="input_ssm_path"></a> [ssm\_path](#input\_ssm\_path) | path to the ssm parameters you want pulled into your container during execution of the entrypoint. | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets for the service. If null, private and public subnets will be looked up based on environment tag and one will be selected based on public\_service. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Extra tags | `map(string)` | `{}` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | Target group name. Will default to product if not defined. | `string` | `null` | no |
| <a name="input_task_def_arn"></a> [task\_def\_arn](#input\_task\_def\_arn) | Task definition ARN. If null, task will be created with default values, except that image\_repo and image\_tag may be defined. | `string` | `null` | no |
| <a name="input_task_family"></a> [task\_family](#input\_task\_family) | Name to use for the task family of the task definition associated with this service. By default, uses name. | `string` | `null` | no |
| <a name="input_virtual_gateway"></a> [virtual\_gateway](#input\_virtual\_gateway) | the name of the virtual gateway associated with this task definition. Only populate if this is an envoy service. | `string` | `null` | no |
| <a name="input_virtual_node"></a> [virtual\_node](#input\_virtual\_node) | The name of the virtual node associated with this service. | `string` | `null` | no |
| <a name="input_virtual_node_protocol"></a> [virtual\_node\_protocol](#input\_virtual\_node\_protocol) | Protocol for the virtual node | `string` | `"http"` | no |
| <a name="input_virtual_service"></a> [virtual\_service](#input\_virtual\_service) | The name of the virtual service associated with this ecs service. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID. If null, one will be looked up based on environment tag. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | Cluster this service is associated with |
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | Name of the main container used by this service |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | One domain name that will resolve to this service. Might not be a valid alias. |
| <a name="output_https_listener_arn"></a> [https\_listener\_arn](#output\_https\_listener\_arn) | ARN of the HTTPS listener. Useful when adding extra ACM certificates to the listener. |
| <a name="output_image_tag"></a> [image\_tag](#output\_image\_tag) | Tag of the image used by this service |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | Load balancer ARN |
| <a name="output_lb_sg"></a> [lb\_sg](#output\_lb\_sg) | Load balancer security group |
| <a name="output_name"></a> [name](#output\_name) | Name of the service |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | CloudMap Service ID |
| <a name="output_service_sg"></a> [service\_sg](#output\_service\_sg) | Service security group |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Subnets used by this service |
| <a name="output_task_def_arn"></a> [task\_def\_arn](#output\_task\_def\_arn) | Current task definition ARN used by this service |
| <a name="output_task_family"></a> [task\_family](#output\_task\_family) | Current task family used by this service |
| <a name="output_virtual_node_name"></a> [virtual\_node\_name](#output\_virtual\_node\_name) | Name of the virtual node |
