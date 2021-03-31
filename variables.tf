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
  default     = "python3.8"
}

variable "sealer_key_version_count" {
  description = "Number of data sealer keys to retain"
  default     = 30
}
