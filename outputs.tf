output "arn" {
  value = aws_secretsmanager_secret.default.arn
}

output "rotation_enabled" {
  value = aws_secretsmanager_secret_rotation.default.rotation_enabled
}
