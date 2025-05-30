variable "name" {
  description = "Lambda function name"
  default     = "binary-aes128-key-rot"
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
  description = "Lambda runtime"
}

variable "sealer_key_version_count" {
  description = "Number of data sealer keys to retain"
  default     = 20
}

variable "tags" {
  description = "A mapping of tags to be supplied to resources where supported"
  type        = map(string)
  default     = {}
}
