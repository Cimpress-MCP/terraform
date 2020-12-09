
variable "bucket_name" {
  type = string
  description = "Bucket's name"
}

variable "transition_storage_class" {
  type = string
  description = "Storage class for S3 bucket transition"
  default = "STANDARD_IA"
}

variable "transition_days" {
  type = string
  description = "Days to start the transition"
  default = "60"
}

variable "force_destroy" {
  description = "Specify if the S3 bucket can be destroy even if data resides inside it"
  default = true
}

############## TAGS #################
#
#
variable "extra_tags" {
  type = map(string)
  description = "A map of additional tags to add to the S3 buckets. Each element in the map must have the key = value format"

  # example:
  # extra_tags = {
  #   "Environment" = "Dev",
  #   "Squad" = "Ops"  
  # }

  default = {}
}
