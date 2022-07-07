terraform {
  required_version = ">= 1.1.7"
  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    aws = {
      version = ">= 4.5.0"
    }
  }
}
