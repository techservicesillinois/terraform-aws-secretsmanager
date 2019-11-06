# shibd-data-sealer

[![Build Status](https://drone.techservices.illinois.edu/api/badges/techservicesillinois/terraform-aws-shibd-data-sealer/status.svg)](https://drone.techservices.illinois.edu/techservicesillinois/terraform-aws-shibd-data-sealer)

Provides a [Secret Manager](https://aws.amazon.com/secrets-manager/)
secret for use with Shibbleth. The secret provided is a base64 encoded
AES128 key, rotated on a daily basis.

Argument Reference
-----------------

The following arguments are supported:

* `service` - (Required) The name of the service associated with
the Shibboleth SP.

* `name` - (Optional) Specifies the friendly name of the new secret.
The secret name can consist of uppercase letters, lowercase letters,
digits, and any of the following characters: /_+=.@- Spaces are not
permitted. Default is ${var.service}-shibd-data-sealer.

* `description` - (Optional) A description of the secret.

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
from 7 to 30 days. The default value is 0.

* `tags` - (Optional) Specifies a key-value map of user-defined
tags that are attached to the secret.

* `automatically_after_days` - (Optional) Specifies the number of
days between automatic scheduled rotations of the secret. The default
value is 1.

 
Attributes Reference
--------------------

The following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the secret.

* `arn` - Amazon Resource Name (ARN) of the secret.

* `rotation_enabled ` - Specifies whether automatic rotation is
enabled for this secret.

Credits
--------------------

**Nota bene** the vast majority of the verbiage on this page was
taken directly from the Terraform manual, and in a few cases from
Amazon's documentation.
