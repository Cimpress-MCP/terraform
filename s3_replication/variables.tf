variable "main_bucket_name" {
  type = "string"
  description = "bucket name"
}

variable "access_roles_name" {
  type = "list"
  description = "list of roles that need access to the buckets"
}

data "aws_caller_identity" "current" {}

################## REPLICA ###############
#
#
provider "aws" {
  alias  = "repl"
  region = "${var.replica_region}"
}

variable "replica_region" {
  type = "string"
  description = "AWS region of the S3 replica"
}

variable "replication_bucket_name" {
  type = "string"
  description = "bucket name used for replication"
}

variable "replica_storage_class" {
  type = "string"
  description = "storage class for S3 bucket replica"
  default = "STANDARD"
}

variable "transition_storage_class" {
  type = "string"
  description = "storage class for S3 bucket transition"
  default = "STANDARD_IA"
}

variable "transition_days" {
  type = "string"
  description = "Transition days for lifecycle. This is applied to both the main and the replica buckets."
  default = "60"
}

############## TAGS #################
#
#
variable "tag_name" {
  type = "string"
  description = "bucket name (tag)"
}

variable "tag_project" {
  type = "string"
  description = "bucket's creator"
}

variable "tag_squad" {
  type = "string"
  description = "bucket's squad"
}
