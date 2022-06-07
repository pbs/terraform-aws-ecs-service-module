variable "private_hosted_zone" {
  type        = string
  description = "Private hosted zone for this service. Populate `TF_VAR_private_hosted_zone` before running any tests to have this value populated."
}
