variable "AWS_ACCESS_KEY_ID" {
    type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
    type = string
}

variable "AWS_REGION" {
    type = string
}

variable "USER_NAME" {
  description = "IAM User Name"
  type        = string
}

variable "USER_ROLE_NAME" {
  description = "IAM User Role Name"
  type        = string
}

variable "ACCOUNT_ID" {
  description = "AWS Secret Access Key"
  type        = string
}
