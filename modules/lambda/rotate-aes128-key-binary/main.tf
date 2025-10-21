data "aws_region" "current" {}

locals {
  tags = merge({ Name = var.name }, var.tags)
}

module "rotate" {
  source = "git@github.com:techservicesillinois/terraform-aws-lambda?ref=v3.0.0"

  environment = {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.region}.amazonaws.com"
      SEALER_KEY_VERSION_COUNT = var.sealer_key_version_count
    }
  }

  description    = "Generate random AES-128 keys in binary form"
  function_name  = var.name
  handler        = "lambda.lambda_handler"
  logging_config = var.logging_config
  publish        = true
  quiet          = false
  runtime        = var.runtime
  source_file    = "${path.module}/lambda.py"
  tags           = local.tags
  timeout        = var.timeout
}

# https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets-required-permissions.html

resource "aws_lambda_permission" "allow_secrets_manager" {
  statement_id = "AllowExecutionFromSecretsManager"

  action        = "lambda:InvokeFunction"
  function_name = module.rotate.lambda_function.function_name
  principal     = "secretsmanager.amazonaws.com"
}
