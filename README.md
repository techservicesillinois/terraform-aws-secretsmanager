# secretsmanager

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-secretsmanager/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-secretsmanager/actions)

Provides a [Secrets Manager](https://aws.amazon.com/secrets-manager/)
secret. A lambda function can optionally be associated with the secret,
in order to perform periodic secret rotation.

Argument Reference
-----------------

The following arguments are supported:

* `service` - (Required) The name of the service associated with
the secret.

* `name` - (Required) Specifies the secret name.
The secret name can consist of uppercase letters, lowercase letters,
digits, and any of the following characters: /_+=.@- Spaces are not
permitted. The name stored in SecretsManager will be in the format
`service/secret_name`.

* `description` - (Optional) A description of the secret. A reasonable
default description is provided.

* `automatically_after_days` - (Optional) Specifies the number of
days between automatic scheduled rotations of the secret. The default
value is 1. **NOTE: Specifying the value 0 suppresses automatic secret
rotation.**
 

* `kms_key_id` - (Optional) Specifies the ARN or alias of the AWS
KMS customer master key (CMK) to be used to encrypt the secret
values in the versions stored in this secret. If you don't specify
this value, then Secrets Manager defaults to using the AWS account's
default CMK (the one named aws/secretsmanager). If the default KMS
CMK with that name doesn't yet exist, then AWS Secrets Manager
creates it for you automatically the first time.

* `policy` - (Optional) A file containing a valid JSON document
representing a resource policy.

* `recovery_window_in_days` - (Optional) Specifies the number of
days that AWS Secrets Manager waits before it can delete the secret.
This value can be 0 to force deletion without recovery or range
from 7 to 30 days. The default value is 0, meaning that the secret
can be immediately reused.

* `tags` - (Optional) Specifies a key-value map of user-defined
tags that are attached to the secret.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the secret.

* `rotation_enabled` - Specifies whether automatic rotation is
enabled for this secret.

* `rotation_lambda_arn` - ARN of lambda function used to perform automatic rotation.
This attribute is omitted if no lambda rotation function is attached to the secret.

Credits
--------------------

**Nota bene** the vast majority of the verbiage on this page was
taken directly from the Terraform manual, and in a few cases from
Amazon's documentation.
