resource "aws_lambda_function" "default" {
  function_name = var.name
  description   = "Generate random AES-128 keys in binary form"
  handler       = "lambda.lambda_handler"
  publish       = true

  role    = aws_iam_role.default.arn
  runtime = var.runtime
  tags    = merge({ Name = var.name }, var.tags)

  filename         = data.archive_file.selected.output_path
  source_code_hash = data.archive_file.selected.output_base64sha256

  environment {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.region}.amazonaws.com"
      SEALER_KEY_VERSION_COUNT = var.sealer_key_version_count
    }
  }
}

# https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets-required-permissions.html
resource "aws_lambda_permission" "allow_secrets_manager" {
  statement_id = "AllowExecutionFromSecretsManager"

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.function_name
  principal     = "secretsmanager.amazonaws.com"
}
