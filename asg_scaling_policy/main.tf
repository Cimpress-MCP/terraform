resource "aws_autoscaling_policy" "asg_scaling_policy_up" {
  name = "${var.name}-asg-${var.metric_name}-scaling-policy-up"
  adjustment_type = "ChangeInCapacity"
  cooldown = "${var.cooldown}"
  scaling_adjustment = "${var.scaling_adjustment_up}"
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_autoscaling_policy" "asg_scaling_policy_down" {
  name = "${var.name}-asg-${var.metric_name}-scaling-policy-down"
  adjustment_type = "ChangeInCapacity"
  cooldown = "${var.cooldown}"
  scaling_adjustment = "${var.scaling_adjustment_down}"
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_cloudwatch_metric_alarm" "metric_alarm_scaleup" {
  alarm_name = "${var.name}-${var.metric_name}-alarm-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "${var.evaluation_periods}"
  metric_name = "${var.metric_name}"
  namespace = "${var.namespace}"
  period = "${var.period}"
  statistic = "${var.statistic_type}"
  threshold = "${var.threshold_up}"
  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }
  alarm_description = "This metric monitor ${var.metric_name} utilization (scale up)"
  alarm_actions = ["${aws_autoscaling_policy.asg_scaling_policy_up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "metric_alarm_scaledown" {
  alarm_name = "${var.name}-${var.metric_name}-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "${var.evaluation_periods}"
  metric_name = "${var.metric_name}"
  namespace = "${var.namespace}"
  period = "${var.period}"
  statistic = "${var.statistic_type}"
  threshold = "${var.threshold_down}"
  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }
  alarm_description = "This metric monitor ${var.metric_name} utilization (scale down)"
  alarm_actions = ["${aws_autoscaling_policy.asg_scaling_policy_down.arn}"]
}