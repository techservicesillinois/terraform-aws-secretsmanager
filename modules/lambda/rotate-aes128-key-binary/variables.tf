variable "logging_config" {
  type = object({
    application_log_level = optional(string)
    log_format            = string
    log_group             = optional(string)
    system_log_level      = optional(string)
  })
  description = "Configuration block for advanced logging settings"
  default     = null
}

variable "name" {
  description = "Lambda function name"
  default     = "rotate-aes128-key-binary"
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

variable "timeout" {
  description = "Lambda function timeout"
  default     = null
}
