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
module "public-subnets" {
  source = "git@github.com:techservicesillinois/terraform-aws-secretsmanager//modules/lambda/rotate-aes128-key-binary"

  name               = "rotate-aes128-key-binary"
  role               = "rotate-aes128-key-binary"
  policy             = "rotate-aes128-key-binary"

  sealer_key_version_count = 21

  # NOTE: This must use a python3 runtime supported by AWS for lambda functions.
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

* `name` - Lambda function name (default is "rotate-aes128-key-binary").

* `role` - Role name (Default AWSLambdaSecretManagerRole).

* `policy` - Policy name (Default AWSLambdaSecretManager).

* `runtime` - Lambda runtime (e.g., "python3.12"). Runtime *must* be Python 3.x.

* `sealer_key_version_count` - Number of data sealer keys to retain.

* `tags` - A map of tags to be supplied to resources where supported.

Attributes Reference
--------------------

The following attributes are exported:

* `qualified_arn` - The Amazon Resource Name (ARN) identifying the
lambda function version.

* `version` - Latest published version of the lambda function.
