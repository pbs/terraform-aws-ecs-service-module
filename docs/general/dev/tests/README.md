# Tests

Tests for this project use [Terratest][terratest]. You need a working [Golang environment][golang] to run them.

The examples in this project are provisioned, validated and destroyed using the tests located [here](/tests).

Run the following script to execute these tests:

```bash
./scripts/test.sh
```

This will provision real Terraform resources in an AWS account, validate their configurations, then tear them down.

Note that the tests can be easily modified by doing one of the following:

- Adding the `-v` flag for verbose output.
- Changing the `timeout` value for tests that take longer to run, or that need to provision more quickly to be considered passing.
- Adding `-count=1` to bypass go test caching.

[terratest]: https://terratest.gruntwork.io/
[golang]: https://golang.org/doc/
