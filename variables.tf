variable "service" {
  description = "Name of service"
}

variable "name" {
  description = "Name of secret"
  default     = ""
}

variable "description" {
  description = "A description of the secret"
  default     = ""
}

variable "kms_key_id" {
  description = "AWS KMS customer master key (CMK) to be used to encrypt the secret"
  default     = ""
}

variable "policy" {
  description = "A filename containing a valid policy document."
  default     = ""
}

variable "recovery_window_in_days" {
  description = "Number of days AWS waits before it deletes the secret"
  default     = 0
}

variable "tags" {
  description = "User-defined tags that are attached to the secret"
  type        = map(string)
  default     = {}
}

variable "automatically_after_days" {
  description = "Number of days between automatic scheduled rotations of the secret"
  default     = 1
}

variable "lambda_function_name" {
  description = "The name of the lambda function that Secret Manageer will use for key rotation"
  default     = "aes128-key-rot"
}
