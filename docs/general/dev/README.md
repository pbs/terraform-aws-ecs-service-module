# Development

## Tests

If you'd like to learn about the tests used in this module, click [here](./tests).

## Validation

Use the [validate.sh](/scripts/validate.sh) script to validate that your Terraform configurations are valid.

```bash
./scripts/validate.sh
```

## Documentation

Documentation for this project is generated using [terraform-docs][terraform-docs].

Use the [document.sh](/scripts/document.sh) to generate standard Terraform documentation with the [header](/README-HEADER.md) file injected above it:

```bash
./scripts/document.sh
```

## Formatting

Use the [format.sh](/scripts/format.sh) script to format your code using canonical Terraform formatting.

```bash
./scripts/format.sh
```

## Wizard

Use the [wizard.sh](/scripts/wizard.sh) script to replace placeholder values located within the Terraform template.

```bash
./scripts/wizard.sh
```

## Hooks

Validation, documentation and formatting scripts are useful to use as [pre-commit hooks](.git/hooks/pre-commit), as they can be re-run without concern and ensure valid, well documented configurations are committed for this module:

```bash
GIT_ROOT=$(git rev-parse --show-toplevel)
"$GIT_ROOT"/scripts/validate.sh
"$GIT_ROOT"/scripts/document.sh
"$GIT_ROOT"/scripts/format.sh
```

## CI

This project is configured to continuously validate the checks mentioned above (with the exception of tests) using the [GitHub Actions](/.github/workflows) in this repo. The actions will fire on any merge request to `main`, and will increment the patch number of the semver of the git tag when merged according to the changes indicated in labels of pull requests.

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
