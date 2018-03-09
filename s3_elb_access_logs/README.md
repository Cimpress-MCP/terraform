# S3 ELB Access Log
This terraform module allows you to create an S3 bucket for ELB access logs.

It enforces the use of tags.

# Example

```
module "s3_elb_log" {
  source = "git::https://github.com/Cimpress-MCP/terraform.git//s3_elb_access_logs"
  
  # name of bucket to create.  Must be unique within AWS
  bucket_name = "s3-elb-logs"

  # Project this bucket is assigned to
  project = "foobar"
}

# Create a new load balancer
resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  access_logs {
    bucket        = "${module.s3_elb_log.bucket_name}" # using module's output to enforce dependency
    interval      = 60
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.foo.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "foobar-terraform-elb"
    Project = "foobar"
  }
}
```
