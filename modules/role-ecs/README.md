# ecs-role

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-sm-secrets-ro-policy/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-sm-secrets-ro-policy/actions)

Provides an IAM role and policy that grant read-only access by ECS services to specific secret(s) for %s service", var.service)

Argument Reference
-----------------

The following arguments are supported:

* `description` - (Optional) A description applied to the IAM policy and role, overriding the default.

* `name_base` - (Optional) A string used as a prefix for the names applied to the IAM policy and role, overriding the default.

* `secrets` - (Required) A list of secret names to allow access to

* `service` - (Required) Service name.

* `tags` - (Optional) Tags to be applied to resources where supported.

Attributes Reference
--------------------

The following attributes are exported:

* `policy_arn` - The Amazon Resource Name (ARN) that identifies the policy

* `role_arn` - The Amazon Resource Name (ARN) that identifies the role

