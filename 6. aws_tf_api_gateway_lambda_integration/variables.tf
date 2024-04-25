variable "AWS_REGION" {
  default   = "us-east-1"
  type      = string
  sensitive = true
}

variable "AWS_ACCOUNT_ID" {
  default   = "Your aws account number"
  type      = string
  sensitive = true
}