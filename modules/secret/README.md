# modules/secret

Provides one or more AWS [Secrets Manager](https://aws.amazon.com/secrets-manager/) secrets.
A lambda function can optionally be associated with each secret,
in order to perform periodic secret rotation.

Example usage
--------------

### An example managing three secrets with various characteristics

```
module "secrets" {
  source = "git@github.com:techservicesillinois/terraform-aws-secretsmanager//modules/secret"

  # Name of service to which secrets belong.
  service = "example"

  secrets = {
    "data-sealer" = {
      automatically_after_days = 5
      description              = "IdP data sealer key for encrypting data in browser cookies"
      function_name            = "rotate-aes128-key-binary"
      recovery_window_in_days  = 21
    }

    "rds-master-password" = {
      automatically_after_days = 3
      description              = "RDS master password"
      function_name            = "rotate-rds-postgresql"
      recovery_window_in_days  = 7
    }

    "secret-without-rotation" = {
      description = "A non-rotating secret"
    }
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `name` - (Required) Specifies the secret name.
The secret name can consist of uppercase letters, lowercase letters,
digits, and any of the following characters: /_+=.@- Spaces are not
permitted. The name stored in SecretsManager will be in the format
`service/secret_name`.

* `description` - (Optional) A description of the secret. A reasonable
default description is provided.

* `kms_key_id` - (Optional) Specifies the ARN or alias of the AWS
KMS customer master key (CMK) to be used to encrypt the secret
values in the versions stored in this secret. If you don't specify
this value, then Secrets Manager defaults to using the AWS account's
default CMK (the one named `aws/secretsmanager`). If the default KMS
CMK with that name doesn't yet exist, then AWS Secrets Manager
creates it automatically the first time.

* `policy` - (Optional) A file containing a valid JSON document
representing a resource policy.

* `secrets` - (Required) A map of maps defining one or more secrets. Each map's key is its
secret name, and the value stored under that key is another map that may
contain the following keys: automatically\_after\_days, description, function\_name,
and recovery\_window\_in\_days.

* `service` - (Required) Name of service with which the secret(s) are
associated. This value is prepended to the name of each secret in
order to follow an orderly hierarchy, and to permit wildcarding in
granting access to secrets. For a service of `class-rosters` and secret
named `foobar`, the name of the secret in Secrets Manager will be
`class-rosters/foobar`.

* `tags` - (Optional) Tags to be applied to resources where supported.

`secrets`
--------

The `secrets` block is a map of maps. The outer map consists of keys, each of
which defines a secret name. 
As noted above, the fully-qualified secret name in Secrets Manager takes the form
`service_name/secret_name`. The value associated with these keys is another map
(the "inner map"), which supports the following key/value pairs:

* `automatically_after_days` * - (Optional) Specifies the number of
days between automatic scheduled rotations of the secret.

* `description` - (Required) Description of the secret.

* `function_name` - (Optional) Name of the lambda function, if any, used to rotate
the secret.

* `recovery_window_in_days` - (Optional) Specifies the number of
days that AWS Secrets Manager waits before it can delete the secret.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` - A map in which each key is the fully-qualified name of the key in Secrets
Manager, and the corresponding value is the secret's Amazon Resource Name (ARN).

* `rotation_lambda_arn` - A map in which each key is the fully-qualified name of the key
in Secrets Manager, and the corresponding value is the ARN of lambda function used to perform automatic rotation.
A secret only appears in this map if a lambda rotation function is assigned for that secret.

Credits
--------------------

**Nota bene** the vast majority of the verbiage on this page was
taken directly from the Terraform manual, and in a few cases from
Amazon's documentation.
