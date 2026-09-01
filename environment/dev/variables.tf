variable "subscription_id" {
  description = "Azure subscription ID. Prefer ARM_* environment variables or OIDC authentication."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "location" {
  description = "Azure location."
  type        = string
}
