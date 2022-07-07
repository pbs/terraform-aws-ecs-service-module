# PBS TF MOD_TITLE

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-MOD_NAME?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

<!-- TODO -->
This should be a basic description of what this module does.
Fill this out before completing usage of this template.
<!-- TODO -->

Integrate this module like so:

```hcl
module "MOD_SHORTNAME" {
  source = "github.com/pbs/terraform-aws-MOD_NAME?ref=x.y.z"

  <!-- TODO -->
  Show some examples of valid values for required parameters.
  <!-- TODO -->

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
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
