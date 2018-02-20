##################################################################################################################
#                                                                                                                #
# Variables define the parameterization of Terraform configurations. Variables can be overridden via the CLI.    #
#                                                                                                                #
# Further reading: https://www.terraform.io/docs/configuration/variables.html                                    #
#                                                                                                                #
##################################################################################################################

/* generic */

variable "default_tags" {
  description = "Default tags which will be applied to everything"
  type        = "map"
  default     = {
                  "Terraform" = "true"
                }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = "map"
  default     = {}
}

variable "automatic_networking" {
  description = "Should we use automatic cidr block creation and AZ allocation"
  type        = "string"
  default     = true
}

variable "manual_azs" {
  description = "Manually define the AZs to use when using automatic_networking"
  type        = "string"
  default     = false
}

variable "automatic_azs" {
  description = "Automatically define the AZs to use when using manual networking"
  type        = "string"
  default     = false
}

/* provider.tf */

variable "aws_region" {
  description = "The region to build in"
  type        = "string"
  default     = "eu-west-1"
}

/* vpc.tf */

variable "vpc_name" {
  description = "The name of the VPC"
  type        = "string"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "vpc_cidr_block" {
  description = "VPC Cidr Block."
  type        = "string"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  type        = "string"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  type        = "string"
  default     = true
}

/* subnets.tf */

variable "az_limit" {
  description = "The number of availability zones to use"
  type        = "string"
  default     = 2
}

variable "azs" {
  description = "A list of Availability zones in the region"
  type        = "list"
  default     = ["dummy", "dummy", "dummy", "dummy", "dummy"]
}

variable "create_private_subnets" {
  description = "Should we create private subnets?"
  type        = "string"
  default     = true
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = "list"
  default     = ["dummy", "dummy", "dummy", "dummy", "dummy"]
}

variable "create_public_subnets" {
  description = "Should we create public subnets?"
  default     = true
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type        = "list"
  default     = ["dummy", "dummy", "dummy", "dummy", "dummy"]
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  type        = "string"
  default     = false
}

/* internet-gateway.tf */

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  type        = "list"
  default     = []
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  type        = "list"
  default     = []
}
