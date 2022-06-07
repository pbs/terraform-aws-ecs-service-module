data "aws_vpc" "vpc" {
  tags = {
    "Name" : "*${var.environment}*"
  }
}
