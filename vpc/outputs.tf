##################################################################################################################
#                                                                                                                #
#  https://www.terraform.io/intro/getting-started/outputs.html                                                   #
#                                                                                                                #
##################################################################################################################

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

/*
  TODO  fix this for new terraform output syntax
        Terraform does not allow conditional operator within outputs

output "availability_zones" {
  value = ["${(var.manual_azs == "1" ? var.azs : data.aws_availability_zones.available.names)}"]
}

output "availability_zones_str" {
  value = "${join(",", (var.manual_azs == "1" ? var.azs : data.aws_availability_zones.available.names))}"
}
*/

output "az_count" {
  value = (var.manual_azs == "1" ? length(var.azs) : var.az_limit)
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "default_security_group_id" {
  value = aws_vpc.vpc.default_security_group_id
}

output "main_route_table_id" {
  value = aws_vpc.vpc.main_route_table_id
}

output "private_subnets" {
  value = [aws_subnet.private.*.id]
}

output "private_subnets_str" {
  value = join(",", aws_subnet.private.*.id)
}

output "public_subnets" {
  value = [aws_subnet.public.*.id]
}

output "public_subnets_str" {
  value = join(",", aws_subnet.public.*.id)
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.*.id
}

output "public_route_table_ids" {
  value = [aws_route_table.public_route_table.*.id]
}

output "public_route_table_ids_str" {
  value = join(",", aws_route_table.public_route_table.*.id)
}

output "private_route_table_ids" {
  value = [aws_route_table.private_route_table.*.id]
}

output "private_route_table_ids_str" {
  value = join(",", aws_route_table.private_route_table.*.id)
}

output "nat_eips" {
  value = [aws_eip.nat_gateway_eip.*.id]
}

output "nat_eips_str" {
  value = join(",", aws_eip.nat_gateway_eip.*.id)
}

output "nat_eips_public_ips" {
  value = [aws_eip.nat_gateway_eip.*.public_ip]
}

output "nat_eips_public_ips_str" {
  value = join(",", aws_eip.nat_gateway_eip.*.public_ip)
}

output "nat_gateway_ids" {
  value = [aws_nat_gateway.nat_gateway.*.id]
}

output "nat_gateway_ids_str" {
  value = join(",", aws_nat_gateway.nat_gateway.*.id)
}
