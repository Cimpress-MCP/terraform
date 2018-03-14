# RDS
The following terraform module creates an RDS instance.

By default, it creates an RDS instance with the following features:
* multi-az
* no public access
* gp2 as storage type 
* 7 days as retention period
* encryption

## Module Input Variables
- `rds_name` - Name of the RDS instance to deploy
- `storage_size` - DB size (in Gb)
- `engine` - DB Engine type, such as mysql or postgres 
- `engine_version` - eg. 9.5.4 in case of postgres
- `instance_class` - instance size, eg. db.t2.micro (see [this table](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) for more details)
- `db_name` - Name of the DB
- `db_user` - db admin username (lowercase, no special chars)
- `db_passwd` - db admin password (must be longer than 8 chars)
- `db_port` - DB port (needed for security group)
- `skip_final_snapshot` - if true (default), DB won't be backed up before deletion
- `instance_sg_id` - Security group ID of the instance allowed to connect to the DB
- `vpc_id` - ID of the VPC where to deploy the RDS instance
- `subnet_ids` - List of VPC's subnets IDs for RDS deployment -in a string form, e.g. "subnet-99a104c1,subnet-e1a93c97"
- `project` - Project name
- `squad` - Owner squad

## Usage
In the follwing example, `instance_sg_id` refers to the security group from
where it's possible to access the RDS instance (since, by default, it's not
publicly accessible).

```
module "rds" {
  source = "git::https://cimpress.githost.io/ips/terraform_modules/rds.git"
  rds_name = "ohmy-rds"
  storage_size = "10"
  engine = "postgres"
  engine_version = "9.6.6"
  instance_class = "db.t2.small"
  db_name = "test_db"
  db_user = "ohmyadmin"
  db_passwd = "ohmypassword"
  db_port = "5432"
  skip_final_snapshot = "true"
  instance_sg_id = "${aws_security_group.instace_sg.id}"
  vpc_id = "vpc-e568d681"
  subnet_ids = "subnet-99a104c1,subnet-e1a93c97"
  project = "ohmy-rds"
  squad = "SET"
}
```

## Output

 - `rds_endpoint` - The endpoint of the DB instance