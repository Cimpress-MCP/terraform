##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/eip.html                                                         #
#                                                                                                                #
##################################################################################################################

resource "aws_eip" "nat_gateway_eip" {
  vpc   = "true"
  count = "${(var.create_private_subnets == "1" ? (var.create_public_subnets == "1" ? (var.automatic_networking == "1" ? (var.manual_azs == "1" ? length(var.azs) : var.az_limit) : (var.automatic_azs == "1" ? var.az_limit : length(var.azs))) : 0) : 0)}"
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/nat_gateway.html                                                 #
#                                                                                                                #
##################################################################################################################

resource "aws_nat_gateway" "nat_gateway" {
  count         = "${(var.create_private_subnets == "1" ? (var.create_public_subnets == "1" ? (var.automatic_networking == "1" ? (var.manual_azs == "1" ? length(var.azs) : var.az_limit) : (var.automatic_azs == "1" ? var.az_limit : length(var.azs))) : 0) : 0)}"

  allocation_id = "${element(aws_eip.nat_gateway_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  depends_on    = ["aws_internet_gateway.internet_gateway"]
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/d/route_table.html                                                 #
#                                                                                                                #
##################################################################################################################

resource "aws_route_table" "private_route_table" {
  count  = "${(var.create_private_subnets == "1" ? (var.automatic_networking == "1" ? (var.manual_azs == "1" ? length(var.azs) : var.az_limit) : (var.automatic_azs == "1" ? var.az_limit : length(var.azs))) : 0)}"
  vpc_id = "${aws_vpc.vpc.id}"

  tags   = "${merge(var.default_tags, var.tags, map("Name", format("%s-route-table-private-%s", var.vpc_name, (var.automatic_networking == "1" ? (var.manual_azs == "1" ? var.azs[count.index] : data.aws_availability_zones.available.names[count.index]) : (var.automatic_azs == "1" ? data.aws_availability_zones.available.names[count.index] : var.azs[count.index])))), map("Created", format("%s", timestamp())))}"

  lifecycle {
      ignore_changes = "tags.Created"
  }
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/route.html                                                       #
#                                                                                                                #
##################################################################################################################

resource "aws_route" "nat_gateway_private_route" {
  count                  = "${(var.create_private_subnets == "1" ? (var.create_public_subnets == "1" ? (var.automatic_networking == "1" ? (var.manual_azs == "1" ? length(var.azs) : var.az_limit) : (var.automatic_azs == "1" ? var.az_limit : length(var.azs))) : 0) : 0)}"
  route_table_id         = "${element(aws_route_table.private_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/route_table_association.html                                     #
#                                                                                                                #
##################################################################################################################

resource "aws_route_table_association" "private_rt_association" {
  count          = "${(var.create_private_subnets == "1" ? (var.automatic_networking == "1" ? (var.manual_azs == "1" ? length(var.azs) : var.az_limit) : length(var.azs)) : 0)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
}

