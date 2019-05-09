data "aws_lambda_function" "selected" {
  function_name = "aes128-key-rot"

  # qualifier defaults to $LATEST
  # Passing an empty string means no qualifier.
  # rotation_lambda_arn brakes if $LATEST is passed!
  qualifier = ""
}

locals {
  policy = "${var.policy == "" ? "empty.json" : var.policy}"
}

resource "aws_secretsmanager_secret" "default" {
  name                    = "${var.name}"
  description             = "${var.description}"
  kms_key_id              = "${var.kms_key_id}"
  policy                  = "${file(local.policy)}"
  recovery_window_in_days = "${var.recovery_window_in_days}"
  tags                    = "${var.tags}"

  rotation_lambda_arn = "${data.aws_lambda_function.selected.arn}"

  rotation_rules {
    automatically_after_days = "${var.automatically_after_days}"
  }
}
