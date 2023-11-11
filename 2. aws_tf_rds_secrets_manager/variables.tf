variable "allocated_storage" {
  description = "The amount of storage to allocate"
  type        = number
  default     = 20
  sensitive   = true
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mariadb"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "10.4.25"
}

variable "instance_class" {
  description = "The instance class to use"
  type        = string
  default     = "db.t4g.small"
}

variable "default_tag" {
  type        = string
  description = "A default tag to add to everything"
  default     = "terraform_aws_rds_secrets_manager"
}