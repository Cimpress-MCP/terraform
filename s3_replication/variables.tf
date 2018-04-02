variable "main_bucket_name" {
  type = "string"
  description = "bucket name"
}

variable "access_roles_name" {
  type = "list"
  description = "list of roles that need access to the buckets"
}

variable "force_destroy" {
  type = "string"
  description = "S3 bucket force destroy"
  default = false
}

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
variable "extra_tags" {
  type = "map"
  description = "A map of additional tags to add to the S3 buckets. Each element in the map must have the key = value format"

  # example:
  # extra_tags = {
  #   "Environment" = "Dev",
  #   "Squad" = "Ops"  
  # }

  default = {}
}
