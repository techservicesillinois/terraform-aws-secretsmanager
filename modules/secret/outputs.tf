output "arn" {
  value = [for secret in aws_secretsmanager_secret.default : secret.arn]
}

output "rotation_lambda_arn" {
  value = { for k, v in aws_secretsmanager_secret.default : k => (contains(keys(aws_secretsmanager_secret_rotation.default), k)) ? aws_secretsmanager_secret_rotation.default[k].rotation_rules[0].automatically_after_days : null }
}

output "rotation_enabled" {
  value = { for k, v in aws_secretsmanager_secret.default : k => (contains(keys(aws_secretsmanager_secret_rotation.default), k)) }
}

#output "rotate_data" {
# value = local.rotate_data
#}

#output "lambda_arns" {
# value = local.lambda_arns
#}
