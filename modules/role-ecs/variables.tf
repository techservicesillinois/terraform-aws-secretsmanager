variable "description" {
  description = "IAM policy description"
  default     = null
}

variable "name_base" {
  description = "Base name for managed IAM resources"
  default     = null
}

variable "secrets" {
  description = "A list of secret names"
  type        = list(string)
}

variable "service" {
  description = "Service name"
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type        = map(string)
  default     = {}
}
