# TF Module Template

Version: `0.0.10`

This is the standard template for Terraform modules. This contains some useful scaffolding to create modules that are:

1. Well documented
2. Tested
3. Shareable

Repos created off of this template will follow the naming convention `terraform-aws-MOD_NAME-module`, replacing MOD_NAME with the name of your module.

## TODO

After creating a repo from this template, your responsibilities are as follows:

- [ ] Run the [wizard.sh](/scripts/wizard.sh) script (`./scripts/wizard.sh`) to populate the boilerplate placeholders with their appropriate values. This includes the proper name of the module and a standardized slug. These values are automatically populated from the name of the repository, but can be adjusted at your discretion.
- [ ] Update [main.tf](/main.tf), [outputs.tf](/outputs.tf), [required.tf](/required.tf) and [optional.tf](/optional.tf) with the configuration for your module (delete files you don't need).
- [ ] Double check that the [terraform.tf](/terraform.tf) and [.tool-versions](/.tool-versions) files have the appropriate versions for resources you are going to use. For major updates, consider updating this template!
- [ ] Create some [examples](/examples) of your module being used. Remember that the examples there will be used for tests that run in real AWS accounts!
- [ ] Create some [tests](/tests) to validate the proper configuration of your module. See instructions [here](/docs/general/dev).
- [ ] Update [README-HEADER.md](/README-HEADER.md) based on the properties of your module. This file will replace the README.md on commit if you follow the instructions [here](/docs/general/dev).
- [ ] Add the git hooks listed under ## Hooks [here](/docs/general/dev). These scripts run as part of the CI, but your development experience will be smoother if you have them running locally as well.
- [ ] Add this template as a remote (`git remote add template git@github.com:pbs/terraform-aws-template-v2.git`). This can be used to allow you to merge back any changes you like from the template into your module.
