output "arn" {
  value = { for k in keys(local.secret_data) : local.secret_data[k] => aws_secretsmanager_secret.default[k].arn }
}

output "rotation_lambda_arn" {
  value = { for k in keys(local.lambda_arns) : local.secret_data[k] => aws_secretsmanager_secret_rotation.default[k].rotation_lambda_arn }
}

output "_rotate_data" {
  value = (var._debug) ? local.rotate_data : null
}

output "_rotation_automatic_after_days" {
  value = (var._debug) ? { for k in keys(local.secret_data) : local.secret_data[k] => (contains(keys(aws_secretsmanager_secret_rotation.default), k)) ? aws_secretsmanager_secret_rotation.default[k].rotation_rules[0].automatically_after_days : null if contains(keys(aws_secretsmanager_secret_rotation.default), k) } : null
}

output "_rotation_enabled" {
  value = (var._debug) ? { for k, v in aws_secretsmanager_secret.default : local.secret_data[k] => (contains(keys(aws_secretsmanager_secret_rotation.default), k)) } : null
}
