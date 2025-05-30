variable "name" {
  description = "Lambda function name"
  default     = "rotate-aes128-key-binary"
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

variable "sealer_key_version_count" {
  description = "Number of data sealer keys to retain"
}

variable "tags" {
  description = "A map of tags to be supplied to resources where supported"
  type        = map(string)
  default     = {}
}
