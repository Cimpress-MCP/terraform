##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html                                            #
#                                                                                                                #
##################################################################################################################

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${(var.create_public_subnets == "1" ? 1 : 0)}"

  tags   = "${merge(var.default_tags, var.tags, map("Name", format("%s-internet-gateway", var.vpc_name)), map("Created", format("%s", timestamp())))}"

  lifecycle {
      ignore_changes = "tags.Created"
  }
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/d/route_table.html                                                 #
#                                                                                                                #
##################################################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id           = "${aws_vpc.vpc.id}"
  count            = "${(var.create_public_subnets == "1" ? 1 : 0)}"

  propagating_vgws = ["${var.public_propagating_vgws}"]
  tags             = "${merge(var.default_tags, var.tags, map("Name", format("%s-route-table-public", var.vpc_name)), map("Created", format("%s", timestamp())))}"

  lifecycle {
      ignore_changes = "tags.Created"
  }
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/route.html                                                       #
#                                                                                                                #
##################################################################################################################

resource "aws_route" "internet_gateway_public_route" {
  count                  = "${(var.create_public_subnets == "1" ? 1 : 0)}"

  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/route_table_association.html                                     #
#                                                                                                                #
##################################################################################################################

resource "aws_route_table_association" "public_rt_association" {
  count          = "${(var.create_public_subnets == "1" ? (var.automatic_networking == "1" ? (var.manual_azs ? length(var.azs) : var.az_limit) : (var.automatic_azs == "1" ? var.az_limit : length(var.public_subnets))) : 0)}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
