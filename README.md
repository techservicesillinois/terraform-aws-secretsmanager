# secretsmanager

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-secretsmanager/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-secretsmanager/actions)

Provide submodules related to Amazon [Secrets Manager](https://aws.amazon.com/secrets-manager/).

The following submodules are provided:

* [lambda/rotate-aes128-key](modules/lambda/rotate-aes128-key/README.md) – rotate a base 64-encoded AES-128 secret.
* [lambda/rotate-aes128-key-binary](modules/lambda/rotate-aes128-key-binary/README.md) – rotate a binary-encoded AES-128 secret.
* [role-ecs](modules/role-ecs/README.md) – manage an IAM role and policy granting ECS tasks access to specific secrets in Secrets Manager.
* [secret](modules/secret/README.md) – manage Secrets Manager secrets.
