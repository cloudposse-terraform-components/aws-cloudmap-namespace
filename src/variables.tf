variable "region" {
  type        = string
  description = "AWS region"
}

variable "description" {
  type        = string
  description = "Description of the Cloud Map Namespace"
}

variable "type" {
  type        = string
  description = "Type of the Cloud Map Namespace"
  default     = "http"
  validation {
    condition     = contains(["http", "private", "public"], var.type)
    error_message = "Invalid namespace type, must be one of `http` or `private` or `public`"
  }
}

variable "create_security_group" {
  type        = bool
  description = "Create security group"
  default     = false
}
