# Inspector Automation
This terraform module allows you to set up automated checks for Inspector.

It needs the inspector tag which has been previously applied to the resources you want to scan against Inspector. The tag has the format `Inspector: <value>`. The `<value>` is specified in `inspector_tag` variable.

The variable `cloudwatch_sched_rule` accepts the same values as specified in the [official AWS documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html).

# Example

```
module "inspector_automation" {
  source = "git::https://github.com/Cimpress-MCP/terraform.git//inspector_automation"

  name = "inspector_test"

  inspector_tag = "scanme"

  template_duration = 3600

  cloudwatch_sched_rule = "rate(15 days)"
}
```
