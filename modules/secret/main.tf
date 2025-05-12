locals {
  policy = var.policy == null ? "empty.json" : var.policy
}

resource "aws_secretsmanager_secret" "default" {
  for_each = var.secrets

  description             = format("%s service: %s", var.service, each.value.description)
  kms_key_id              = var.kms_key_id
  name                    = format("%s/%s", var.service, each.key)
  policy                  = file(local.policy)
  recovery_window_in_days = each.value.recovery_window_in_days
  tags                    = merge({ "Name" = each.key }, var.tags)

}

locals {
  rotate_data = { for k, v in aws_secretsmanager_secret.default : k => tomap({ automatically_after_days = var.secrets[k].automatically_after_days, function_name = var.secrets[k].function_name }) if var.secrets[k].automatically_after_days != null && var.secrets[k].function_name != null }
}

# For every rotating secret, look up lambda function by name.

data "aws_lambda_function" "selected" {
  for_each = local.rotate_data

  function_name = each.value.function_name

  # qualifier defaults to $LATEST
  # Passing an empty string means no qualifier.
  # rotation_lambda_arn breaks if $LATEST is passed!
  # qualifier = null
}

locals {
  lambda_arns = { for k, v in data.aws_lambda_function.selected : k => v.arn }
}

#resource "aws_secretsmanager_policy" "default" {
#}

resource "aws_secretsmanager_secret_rotation" "default" {
  for_each = { for k, v in aws_secretsmanager_secret.default : k => v if contains(keys(data.aws_lambda_function.selected), k) }

  secret_id           = each.value.id
  rotation_lambda_arn = local.lambda_arns[each.key]

  # TODO: eventually allow duration and schedule_expression.
  rotation_rules {
    automatically_after_days = local.rotate_data[each.key].automatically_after_days
  }
}
