# AutoScaling Group SNS Notification
This terraform module allows you to associate an SNS topic to a set of autoscaling groups.

# Input variables
- `asg_names` - A comma separeted list of AutoScaling Group names.
- `sns_topic` - The ARN of the SNS topic to send the notification to.

# Output variables
Nothing is created in output.

# Example

```
module "asg_sns_notification" {
  source = "git::https://github.com/Cimpress-MCP/terraform.git//asg_sns_notifications"

  asg_names = "${aws_autoscaling_group.asgone.name},${aws_autoscaling_group.asg_two.name}"

  sns_topic = "arn:aws:sns:eu-west-1:XXXXXXXXXXXX:SlackNotify"
}
```