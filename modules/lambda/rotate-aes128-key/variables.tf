variable "name" {
  description = "Lambda function name"
  default     = "rotate-aes128-key"
}

variable "role" {
  description = "Role name"
  default     = "AWSLambdaSecretManagerRole"
}

variable "policy" {
  description = "Policy name"
  default     = "AWSLambdaSecretManager"
}

variable "runtime" {
  description = "Lambda runtime (e.g., \"python3.12\")."
}

variable "tags" {
  description = "A map of tags to be supplied to resources where supported"
  type        = map(string)
  default     = {}
}
