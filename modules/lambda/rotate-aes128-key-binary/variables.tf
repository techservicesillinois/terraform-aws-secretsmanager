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
