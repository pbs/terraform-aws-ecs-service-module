# PBS TF ecs service module

## Installation

### Using the Repo Source

```hcl
github.com/pbs/terraform-aws-ecs-service-module?ref=x.y.z
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
  source = "github.com/pbs/terraform-aws-ecs-service-module?ref=x.y.z"

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

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
