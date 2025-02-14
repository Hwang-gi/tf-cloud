variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "eks_name" {
  type = string
}

variable "eks_id" {
  type = string
}

variable "user_name" {
  description = "IAM User Name"
  type        = string
}

variable "account_id" {
  description = "AWS Secret Access Key"
  type        = string
}
