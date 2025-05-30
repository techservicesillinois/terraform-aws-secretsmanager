variable "kms_key_id" {
  description = "AWS KMS customer master key (CMK) to be used to encrypt the secret"
  default     = null
}

variable "policy" {
  description = "Path of file containing a valid policy document"
  default     = null
}

variable "secrets" {
  description = "Secrets expressed as a map of maps. Each map's key is its secret name, and the value stored under that key is another map that may contain the following keys: automatically_after_days, description, function_name, and recovery_window_in_days."
  type = map(
    object({
      # TODO: Support schedule_expression in lieu of automatically_after_days?
      # TODO: Validate automatically_after_days and function_name are both
      # specified, or neither is.
      automatically_after_days = optional(number, null)
      description              = string
      function_name            = optional(string, null)
      recovery_window_in_days  = optional(number, null)
    })
  )
}

variable "service" {
  description = "Service name"
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type    = map(string)
  default = {}
}

# Debugging.

variable "_debug" {
  description = "Produce debug output (boolean)"
  type        = bool
  default     = false
}
