variable "aws_region" {
  description = "AWS region for TFE PoC"
  type        = string
  default     = "ap-northeast-2"
}

variable "created_by" {
  description = "Required CreatedBy tag"
  type        = string
  default     = "cw.lee"
}

variable "project" {
  description = "Required Project tag"
  type        = string
  default     = "cw-tfe-test"
}

variable "purpose" {
  description = "Required Purpose tag"
  type        = string
  default     = "cw-tfe-test"
}

#####################################################
# PoC Test
#####################################################
variable "instance_type" {
  description = "EC2 instance type for TFE PoC"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "enable_good_sg" {
  description = "Enable compliant security group"
  type        = bool
  default     = false
}

variable "enable_bad_sg" {
  description = "Enable non-compliant security group"
  type        = bool
  default     = false
}