variable "tfe_hostname" {
  description = "Terraform Enterprise hostname"
  type        = string
  default     = "ec2-3-35-137-82.ap-northeast-2.compute.amazonaws.com"
}

variable "organization" {
  description = "Terraform Enterprise organization"
  type        = string
  default     = "cw-tfe-test"
}

variable "workspace_name" {
  description = "Target workspace"
  type        = string
  default     = "cw-tfe-test"
}

variable "policy_mode" {
  description = "Security policy enforcement mode"
  type        = string
  default     = "advisory"

  validation {
    condition = contains([
      "none",
      "advisory",
      "soft-mandatory",
      "hard-mandatory"
    ], var.policy_mode)

    error_message = "policy_mode must be none, advisory, soft-mandatory, or hard-mandatory."
  }
}