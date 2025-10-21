# Create and attach policy that grants the lambda function access
# to SecretsManager.
#
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets-required-permissions.html

data "aws_iam_policy_document" "default" {
  statement {
    condition {
      test     = "StringEquals"
      variable = "secretsmanager:resource/AllowRotationLambdaArn"
      values   = [module.rotate.lambda_function.arn]
    }

    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "default" {
  name   = var.name
  path   = "/"
  policy = data.aws_iam_policy_document.default.json
  tags   = local.tags
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = module.rotate.role.name
  policy_arn = aws_iam_policy.default.arn
}
