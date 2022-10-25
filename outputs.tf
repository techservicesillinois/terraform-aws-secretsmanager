output "arn" {
  value = aws_secretsmanager_secret.default.arn
}

output "rotation_lambda_arn" {
  value = var.automatically_after_days > 0 ? data.aws_lambda_function.selected[0].arn : null
}

output "rotation_enabled" {
  value = var.automatically_after_days > 0 ? aws_secretsmanager_secret_rotation.default[0].rotation_enabled : false
}
