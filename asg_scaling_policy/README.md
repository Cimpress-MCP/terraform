# AutoScaling Group Scaling Policy
This terraform module allows you to create autoscaling policies to attach to your ASG.

The fill some of the input variables you may have a look here: [https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CW_Support_For_AWS.html](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CW_Support_For_AWS.html).

# Input variables
- `name` - Name of the whole infrastructure.
- `asg_name` - Name of the autoscaling group to attach the policy to.
- `metric_name` - Name of the metric.
- `namespace` - Namespace for the specified metric.
- `statistic_type` - Type of the statistic (average, minimum, maximum, sum)
- `cooldown` - Cooldown period, in seconds. Default is 300.
- `scaling_adjustment_up` - How many instances need to be spun up. Default is 1.
- `scaling_adjustment_down` - How many instances need to be spun down. Default is -1.
- `evaluation_periods` - How many times we need to evaulate the period before taking action. Default is 3.
- `period` - How many seconds should the check last. Default is 60.
- `threshold_up` - Value that define when a scale up is needed. Default is 80.
- `threshold_down` - Value that define when a scale down is needed. Default is 10.

# Output variables
Nothing is created in output.


```
resource "aws_autoscaling_group" "bar" {
  availability_zones        = ["us-east-1a"]
  name                      = "foobar3-terraform-test"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  placement_group           = "${aws_placement_group.test.id}"
  launch_configuration      = "${aws_launch_configuration.foobar.name}"

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  }
}

module "asg_scaling" {
  source = "git::https://github.com/Cimpress-MCP/terraform.git//s3_replication"

  name = "custom-asg-scaling"

  asg_name = "${aws_autoscaling_group.bar.name}"

  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  statistic_type = "Average"
}
```