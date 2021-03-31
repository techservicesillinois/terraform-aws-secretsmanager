# binary-aes128-key-rotation

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-binary-aes128-key-rotation/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-binary-aes128-key-rotation/actions)

Provides a lambda function, IAM role, and policy to generate binary AES128 keys in a binary format
for [Secret Manager](https://aws.amazon.com/secrets-manager/). This
may be used with module
[shibd-data-sealer](https://github.com/techservicesillinois/terraform-aws-shibd-data-sealer).

Argument Reference
-----------------

The following arguments are supported:

* `name` - Lambda function name (Default binary-aes128-key-rot).

* `role` - Role name (Default AWSLambdaSecretManagerRole).

* `policy` - Policy name (Default AWSLambdaSecretManager).

* `runtime` - Lambda runtime (Default python3.8).

* `sealer_key_version_count` - Number of data sealer keys to retain (Default 30).

Attributes Reference
--------------------

The following attributes are exported:

* `qualified_arn` - The Amazon Resource Name (ARN) identifying your
Lambda Function Version.

* `version` - Latest published version of your Lambda Function.
