data "aws_lambda_function" "selected" {
  function_name = var.lambda_function_name

  # qualifier defaults to $LATEST
  # Passing an empty string means no qualifier.
  # rotation_lambda_arn brakes if $LATEST is passed!
  qualifier = ""
}

locals {
  policy = var.policy == "" ? "empty.json" : var.policy

  default_name = "${var.service}-shibd-data-sealer"
  name         = var.name != "" ? var.name : local.default_name

  default_description = "Shibboleth SP data sealer for ${var.service}"
  description         = var.description != "" ? var.description : local.default_description
}

resource "aws_secretsmanager_secret" "default" {
  name                    = local.name
  description             = local.description
  kms_key_id              = var.kms_key_id
  policy                  = file(local.policy)
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = var.tags

  rotation_lambda_arn = data.aws_lambda_function.selected.arn

  rotation_rules {
    automatically_after_days = var.automatically_after_days
  }
}
