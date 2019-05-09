output "id" {
  value = "${aws_secretsmanager_secret.default.id}"
}

output "arn" {
  value = "${aws_secretsmanager_secret.default.arn}"
}

output "rotation_enabled" {
  value = "${aws_secretsmanager_secret.default.rotation_enabled}"
}
