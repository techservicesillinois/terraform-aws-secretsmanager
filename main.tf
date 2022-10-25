data "aws_lambda_function" "selected" {
  count = var.automatically_after_days > 0 ? 1 : 0

  function_name = var.lambda_function_name

  # qualifier defaults to $LATEST
  # Passing an empty string means no qualifier.
  # rotation_lambda_arn breaks if $LATEST is passed!
  qualifier = null
}

locals {
  default_description = format("secret for %s service", var.service)
  description         = var.description != null ? var.description : local.default_description
  name                = var.name
  policy              = var.policy == null ? "empty.json" : var.policy
}

resource "aws_secretsmanager_secret" "default" {
  name                    = format("%s/%s", var.service, local.name)
  description             = local.description
  kms_key_id              = var.kms_key_id
  policy                  = file(local.policy)
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_rotation" "default" {
  count = var.automatically_after_days > 0 ? 1 : 0

  secret_id           = aws_secretsmanager_secret.default.id
  rotation_lambda_arn = data.aws_lambda_function.selected[0].arn

  rotation_rules {
    automatically_after_days = var.automatically_after_days
  }
}
