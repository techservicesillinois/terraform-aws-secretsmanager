# rotate-aes128-key-binary

Provides a lambda function, IAM role, and policy to manage the
periodic rotation of secrets for
[Secret Manager](https://aws.amazon.com/secrets-manager/).

The specific use case for this submodule is to manage the rotation of
secrets in binary AES128 format, which are used as Shibboleth IdP
data sealer keys.

The characteristics of the secret (like its rotation frequency) are
defined using the
[terraform-aws-secretsmanager//modules/secret](https://github.com/techservicesillinois/terraform-aws-secretsmanager//modules/secret) module.

Example Usage
-----------------

```hcl
module "lambda" {
  source = "git@github.com:techservicesillinois/terraform-aws-secretsmanager//modules/lambda/rotate-aes128-key-binary"

  name                     = "rotate-aes128-key-binary"
  sealer_key_version_count = 21

  # NOTE: Runtime *must* be an AWS-supported python3.x version.
  # See https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html.
  runtime = "python3.12"

  tags = {
    Service = "sso"
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `logging_config` - (Optional) A [`logging_config`](#logging_config) block containing advanced logging settings.

* `name` - (Optional) Lambda function name (default is "rotate-aes128-key-binary").

* `runtime` - (Required) Lambda runtime (e.g., "python3.12"). Runtime *must* be Python 3.x.

* `sealer_key_version_count` - (Required) Number of data sealer keys to retain.

* `tags` - (Optional) A map of tags to be supplied to resources where supported.

* `timeout` - (Optional) Lambda function timeout.

`logging_config`
-------
A `logging_config` block supports the following.

* `application_log_level` - (Optional) Detail level of application logs.

* `log_format` - (Required) Log format.

* `log_group` - (Optional) CloudWatch log group where logs are sent.

* `system_log_level` - (Optional) Detail level of Lambda platform logs.

Attributes Reference
--------------------

The following attributes are exported:

* `qualified_arn` - The Amazon Resource Name (ARN) identifying the
lambda function version.

* `version` - Latest published version of the lambda function.
