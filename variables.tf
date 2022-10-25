variable "automatically_after_days" {
  description = "Number of days between automatic scheduled rotations of the secret"
  default     = 1
}

variable "description" {
  description = "Description of the secret"
  default     = null
}

variable "kms_key_id" {
  description = "AWS KMS customer master key (CMK) to be used to encrypt the secret"
  default     = null
}

variable "lambda_function_name" {
  description = "Name of lambda function used by Secrets Manager for key rotation"
  default     = null
}

variable "name" {
  description = "Secret name"
}

variable "policy" {
  description = "Path of file containing a valid policy document"
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days AWS waits before deleting the secret"
  default     = 0
}

variable "service" {
  description = "Service name"
}

variable "tags" {
  description = "User-defined tags attached to the secret"
  type        = map(string)
  default     = {}
}
