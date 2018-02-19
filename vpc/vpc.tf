##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/d/vpc.html                                                         #
#                                                                                                                #
##################################################################################################################

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_support   = "${var.enable_dns_hostnames}"
  enable_dns_hostnames = "${var.enable_dns_support}"

  tags                 = "${merge(var.default_tags, var.tags, map("Name", format("%s", var.vpc_name)), map("Created", format("%s", timestamp())))}"

  lifecycle {
      ignore_changes = "tags.Created"
  }
}
