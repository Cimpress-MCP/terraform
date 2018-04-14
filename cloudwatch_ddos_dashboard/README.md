# Cloudwatch DDoS Dashboard
This terraform module allows you to create a Cloudwatch dashboard with metrics used to monitor your LB's network activity, to identify possible surge in traffic which, in turn, may be an indicator of a DDoS attack.

Metrics collected for Classic Load Balancers are:
* RequestCount
* BackendConnectionErrors
* HTTPCode_ELB_5XX
* Latency
* HTTPCode_Backend_3XX
* HTTPCode_Backend_4XX

Metrics collected for Application Load Balancers are:
* RequestCount
* ActiveConnectionCount
* HTTPCode_ELB_4XX_Count
* TargetResponseTime
* HTTPCode_Target_3XX_Count
* HTTPCode_Target_4XX_Count

The metrics are updated every 60 seconds.

# Module input variables
- `dashboard_name` - CloudWatch's dashboard name
- `app_lb` - true/false value. Select `true` if the dashboard is attached to an Application Load Balancer
- `lb_name` - Load Balancer's name (if `app_lb` is true, you want to select the lb's `arn_suffix` here)
- `period` - how often the data will be updated (default 60 seconds)

# Example

```
resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

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
  }
}

module "cloudwatch_dashboard" {
  source = "git::https://github.com/Cimpress-MCP/terraform.git//cloudwatch_ddos_dashboard"

  dashboard_name = "monitor-ddos"

  lb_name = "${aws_elb.bar.name}"
}
```
