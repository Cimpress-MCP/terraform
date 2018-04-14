variable "rds_name" {
  type = "string"
  description = "RDS instance name"
}

variable "storage_size" {
  type = "string"
  description = "RDS allocated storage"
}

variable "storage_type" {
  type = "string"
  description = "Storage type"
  default = "gp2"
}

variable "engine" {
  type = "string"
  description = "RDS engine"
}

variable "engine_version" {
  type = "string"
  description = "RDS engine version"
}

variable "instance_class" {
  type = "string"
  description = "RDS instance class"
}

variable "db_name" {
  type = "string"
  description = "RDS DB name"
}

variable "db_user" {
  type = "string"
  description = "RDS DB username"
}

variable "db_passwd" {
  type = "string"
  description = "RDS DB password"
}

variable "db_port" {
  type = "string"
  description = "Port where the DB listen"
}

variable "multi_az" {
  type = "string"
  description = "RDS multi availability zone support (default true)"
  default = true
}

variable "public_access" {
  type = "string"
  description = "RDS public access (default false)"
  default = false
}

variable "skip_final_snapshot" {
  type = "string"
  description = "RDS skip final snapshot"
}

variable "retention_period" {
  type = "string"
  description = "RDS backup data retention period (default 7 days)"
  default = 7
}

variable "instance_sg_id" {
  type = "string"
  description = "Instance's security group id to add as cidr block"
}

variable "encryption" {
  type = "string"
  description = "Enable or not storage encryption"
  default = true
}

############ Tags ##############
#
#
variable "project" {
  type = "string"
  description = "The Project Name for this infrastructure"
}

variable "squad" {
  type = "string"
  description = "The squad/team who owns the infrastructure"
}

variable "extra_tags" {
  type = "map"
  description = "A map of additional tags to add to ELBs and SGs. Each element in the map must have the key = value format"

  # example:
  # extra_tags = {
  #   "Environment" = "Dev",
  #   "Squad" = "Ops"
  # }

  default = {}
}

########### Infrastructure ############
#
#
variable "vpc_id" {
  description = "ID of the VPC where to deploy the infrastructure."
}

variable "subnet_ids" {
  type = "string"
  description = "Subnet's ids (comma seperated)"
}