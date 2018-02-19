vpc terraform module
===========

A terraform module to provide a VPC in AWS.

This a fork of (https://github.com/terraformworld/terraform-aws-vpc) with additional functionality.


Module Input Variables
----------------------

- `aws_region` - the aws region in which to build the resources (Default: eu-west-1)
- `vpc_name` - the name of the vpc and the name to be used on all the resources created by the module (required)
- `vpc_cidr_block` - the CIDR block for the VPC (required)
- `automatic_networking` - enable or disable automatic networking (automatic creation of public/private subnets)
- `create_private_subnets` - enable or disable the creation of private subnets (default: true)
- `create_public_subnets` - enable or disable the creation of public subnets (default: true)
- `az_limit` - the number of availability zones to use when automatic_networking in enabled (default: 2)
- `manual_azs` - enable or disable automatic availability zone allocation (when automatic_networking = true)
- `automatic_azs` - enable or disable automatic availability zone allocation (when automatic_networking = false)
- `instance_tenancy` - tenancy option for instances launched into the VPC (optional)
- `public_subnets` - list of public subnet cidrs (optional)
- `private_subnets` - list of private subnet cidrs (optional)
- `azs` - list of AZs in which to distribute subnets (optional)
- `enable_dns_hostnames` - should be true if you want to use private DNS within the VPC
- `enable_dns_support` - should be true if you want to use private DNS within the VPC
- `map_public_ip_on_launch` - should be false if you do not want to auto-assign public IP on launch
- `private_propagating_vgws` - list of VGWs the private route table should propagate
- `public_propagating_vgws` - list of VGWs the public route table should propagate
- `default_tags` - dictionary of tags that will be added to resources created by the module
- `tags` - optional additional tags to be added to resources created by the module

Usage
-----

Automatic (Default)

```hcl
module "vpc" {
  source = "<path to module>"

  vpc_name        = "my-vpc"
  vpc_cidr_block  = "10.100.0.0/16"
}

```

Manual

```hcl
module "vpc" {
  source = "<path to module>"

  vpc_name        = "my-vpc"

  my_cidr_block   = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
```

Advanced options (Manually defined availability zones with automatic networking)

```hcl
module "vpc" {
  source = "path to module"

  vpc_name        = "my-vpc"
  vpc_cidr_block  = "10.100.0.0/16"

  manual_azs      = true
  azs             = ["us-west-2b", "us-west-2c"]
}

```

Advanced options (Automatically defined availability zones with manual networking)

```hcl
module "vpc" {
  source = "<path to module>"

  vpc_name        = "my-vpc"
  my_cidr_block   = "10.0.0.0/16"

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  automatic_azs   = true
}
```

Advanced options (Custom tags)

```hcl
module "vpc" {
  source = "path to module"

  vpc_name        = "my-vpc"
  vpc_cidr_block  = "10.100.0.0/16"

  tags {
    "Environment" = "${var.environment}"
    "Last Run" = "${format("%s", timestamp())}"
  }
}

```

Output
-----
 - `account_id` - the id of the acount the vpc has been created in
 - `vpc_id` - does what it says on the tin
 - `vpc_cidr_block` - the cidr block used for the VPC
 - `availability_zones` - a list of availability_zones the resources have been built in
 - `availability_zones_str` - a comma separated string of availability_zones the resources have been built in
 - `az_count` - the number of availability zones resources have been built in
 - `private_subnets` - list of private subnet ids
 - `private_subnets_str` - a comma separated string of private subnet ids
 - `public_subnets` - list of public subnet ids
 - `public_subnets_str` - a comma separated string of public subnet ids
 - `public_route_table_ids` - list of public route table ids
 - `public_route_table_ids_str` - a comma separated string of public route table ids
 - `private_route_table_ids` - list of private route table ids
 - `private_route_table_ids_str` - a comma separated string of private route table ids
 - `default_security_group_id` - VPC default security group id string
 - `main_route_table_id` - id of the main route table for the VPC
 - `nat_eips` - list of Elastic IP ids (if any are provisioned)
 - `nat_eips_str` - a comma separated string of Elastic IP ids (if any are provisioned)
 - `nat_eips_public_ips` - list of NAT gateways' public Elastic IP's (if any are provisioned)
 - `nat_eips_public_ips_str` - a comma separated string of NAT gateways' public Elastic IP's (if any are provisioned)
 - `nat_gateway_ids` - list of NAT gateway ids
 - `nat_gateway_ids_str` - a comma separated string of NAT gateway ids
 - `internet_gateway_id` - Internet Gateway id string

TODO
----
