variable "cluster_name" {
  description = "Name of the cluster"
  default     = null
  type        = string
}

variable "cluster_ec2_backed" {
  description = "Whether or not to provision an autoscaled EC2 fleet to back the cluster"
  default     = false
  type        = bool
}

variable "cluster_instance_type" {
  description = "Instance type to use for EC2 backed cluster"
  default     = "m7a.xlarge"
  type        = string
}

variable "cluster_max_size" {
  description = "Maximum size for the autoscaling group to scale out to for the cluster"
  default     = 25
  type        = number
}

variable "cluster_min_size" {
  description = "Minimum size for the autoscaling group to scale out to for the cluster"
  default     = 3
  type        = number
}

variable "cluster_role_policy_json" {
  description = "(optional) IAM policy to attach to role used for the instance profile of instances in this cluster"
  default     = null
  type        = string
}

variable "cluster_max_instance_lifetime" {
  description = "Maximum lifetime for an instance in the autoscaling group"
  default     = 604800 # 1 week
  type        = number
}

variable "cluster_protect_from_scale_in" {
  description = "Allow ECS to protect instances running tasks from being terminated while tasks are running on them. Must be false when destroying cluster"
  default     = true
  type        = bool
}

variable "cluster_maximum_scaling_step_size" {
  description = "Capacity provider maximum scaling step size"
  default     = 10
  type        = number
}

variable "cluster_minimum_scaling_step_size" {
  description = "Capacity provider maximum scaling step size"
  default     = 1
  type        = number
}

variable "cluster_target_capacity" {
  description = "Capacity provider target capacity"
  default     = 75
  type        = number
}

variable "cluster_launch_template_version" {
  description = "Version of the launch template to use"
  default     = "$Latest"
  type        = string
}
