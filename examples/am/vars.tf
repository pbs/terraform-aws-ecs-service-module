variable "primary_hosted_zone" {
  type        = string
  description = "Primary hosted zone for this service. Populate `TF_VAR_primary_hosted_zone` before running any tests to have this value populated."
}

variable "v1_weight" {
  type        = number
  default     = 100
  description = "Weight for the v1 service"
}

variable "v2_weight" {
  type        = number
  default     = 0
  description = "Weight for the v2 service"
}
