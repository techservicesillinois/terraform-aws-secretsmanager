output "qualified_arn" {
  value = module.rotate.lambda_function.qualified_arn
}

output "version" {
  value = module.rotate.lambda_function.version
}
