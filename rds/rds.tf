resource "aws_db_instance" "rds_instance" {
  allocated_storage         = "${var.storage_size}"
  storage_type              = "${var.storage_type}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  instance_class            = "${var.instance_class}"
  identifier                = "${var.rds_name}"
  name                      = "${var.db_name}"
  username                  = "${var.db_user}"
  password                  = "${var.db_passwd}"
  multi_az                  = "${var.multi_az}"
  license_model             = "${var.license_model}"
  vpc_security_group_ids    = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name      = "${aws_db_subnet_group.rds_subnet.id}"
  publicly_accessible       = "${var.public_access}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${var.rds_name}-final-snap"
  backup_retention_period   = "${var.retention_period}"

  copy_tags_to_snapshot = true

  storage_encrypted = "${var.encryption}"

  tags = "${merge(map("Name", "${var.rds_name}"), var.extra_tags)}"

  timeouts {
    create = "${var.db_create_timeout}"
    delete = "${var.db_delete_timeout}"
    update = "${var.db_update_timeout}"
  }
}

resource "aws_db_subnet_group" "rds_subnet" {
  name        = "${var.rds_name}-db-subnet"
  description = "Our main group of subnets"
  subnet_ids  = ["${split(",", var.subnet_ids)}"]
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg-${var.rds_name}"
  description = "RDS ${var.rds_name} traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.db_port}"
    to_port         = "${var.db_port}"
    protocol        = "TCP"
    security_groups = ["${var.instance_sg_id}"]
  }

  tags = "${merge(map("Name", "${var.rds_name}-rds-sg"), var.extra_tags)}"
}
