locals {
  description = format("Grant read-only access by ECS services to specific secret(s) for %s service", var.service)
  name_base   = var.name_base != null ? var.name_base : format("%s-secrets-ecs", var.service)
  secrets     = [for s in var.secrets : format("%s/%s", var.service, s)]
  tags        = merge({ Name = local.name_base }, var.tags)
}

data "aws_secretsmanager_secret" "selected" {
  for_each = toset(local.secrets)
  name     = each.key
}

resource "aws_iam_policy" "default" {
  name        = format("%s-policy", local.name_base)
  path        = "/"
  description = var.description != null ? var.description : local.description

  policy = data.aws_iam_policy_document.default.json
  tags   = local.tags
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [for s in data.aws_secretsmanager_secret.selected : s.arn]
  }
}

data "aws_iam_policy_document" "ecs-secrets-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default" {
  assume_role_policy = data.aws_iam_policy_document.ecs-secrets-assume-role.json
  description        = var.description != null ? var.description : local.description
  name               = format("%s-role", local.name_base)
  path               = "/"
  tags               = local.tags
}

# locals {
#   name        = "${var.service}-shibd-data-sealer"
#   role_name   = var.role_name != null ? var.role_name : local.name
#   policy_name = var.policy_name != null ? var.policy_name : local.name
#   secret_name = var.secret_name != null ? var.secret_name : local.name
#   tags        = merge({ Name = local.name }, var.tags)
# }

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}
