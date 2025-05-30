# aes128-key-rotation

Provides a lambda function, IAM role, and policy to manage the
periodic rotation of secrets for
[Secret Manager](https://aws.amazon.com/secrets-manager/).

The specific use case for this submodule is to manage the rotation of
secrets in base 64-encoded AES128 format for the "Shib-in-a-box"
application, which has been retired..

The characteristics of the secret (like its rotation frequency) are
defined using the
[terraform-aws-secretsmanager//modules/secret](https://github.com/techservicesillinois/terraform-aws-secretsmanager//modules/secret) module.

Argument Reference
-----------------

The following arguments are supported:

* `name` - Lambda function name (default is "rotate-aes128-key").

* `role` - Role name (Default AWSLambdaSecretManagerRole).

* `policy` - Policy name (Default AWSLambdaSecretManager).

* `runtime` - Lambda runtime (e.g., "python3.12"). Runtime *must* be Python 3.x.

* `tags` - A map of tags to be supplied to resources where supported.

Attributes Reference
--------------------

The following attributes are exported:

* `qualified_arn` - The Amazon Resource Name (ARN) identifying the
lambda function version.

* `version` - Latest published version of the lambda function.
