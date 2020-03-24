##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/subnet.html                                                      #
#                                                                                                                #
##################################################################################################################

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id

  count             = (var.create_private_subnets ? (var.automatic_networking  ? (var.manual_azs  ? length(var.azs) : var.az_limit) : (var.automatic_azs  ? var.az_limit : length(var.private_subnets))) : 0)
  cidr_block        = (var.automatic_networking ? cidrsubnet(aws_vpc.vpc.cidr_block, (var.manual_azs ? length(var.azs) : var.az_limit), count.index) : var.private_subnets[count.index])
  availability_zone = (var.automatic_networking  ? (var.manual_azs  ? var.azs[count.index] : data.aws_availability_zones.available.names[count.index]) : (var.automatic_azs  ? data.aws_availability_zones.available.names[count.index] : var.azs[count.index]))

  tags              = merge(var.default_tags, var.tags, map("Name", format("%s-subnet-private-%s", var.vpc_name, (var.automatic_networking  ? (var.automatic_networking  ? var.azs[count.index] : data.aws_availability_zones.available.names[count.index]) : (var.automatic_azs  ? data.aws_availability_zones.available.names[count.index] : var.azs[count.index])))), map("Env","private"), map("Created", format("%s", timestamp())))

  lifecycle {
      ignore_changes = [tags.Created]
  }
}

##################################################################################################################
#                                                                                                                #
# https://www.terraform.io/docs/providers/aws/r/subnet.html                                                      #
#                                                                                                                #
##################################################################################################################

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id

  count                   = (var.create_public_subnets ? (var.automatic_networking  ? (var.manual_azs  ? length(var.azs) : var.az_limit) : (var.automatic_azs ? var.az_limit : length(var.public_subnets))) : 0)
  cidr_block              = (var.automatic_networking ? cidrsubnet(aws_vpc.vpc.cidr_block, (var.manual_azs  ? length(var.azs) : var.az_limit), (var.manual_azs ? length(var.azs) : var.az_limit) + count.index) : var.public_subnets[count.index])
  availability_zone       = (var.automatic_networking  ? (var.manual_azs  ? var.azs[count.index] : data.aws_availability_zones.available.names[count.index]) : (var.automatic_azs ? data.aws_availability_zones.available.names[count.index] : var.azs[count.index]))

  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags                    = merge(var.default_tags, var.tags, map("Name", format("%s-subnet-public-%s", var.vpc_name, (var.automatic_networking ? (var.automatic_networking ? var.azs[count.index] : data.aws_availability_zones.available.names[count.index]) : (var.automatic_azs ? data.aws_availability_zones.available.names[count.index] : var.azs[count.index])))), map("Env","public"), map("Created", format("%s", timestamp())))

  lifecycle {
      ignore_changes = [tags.Created]
  }
}
