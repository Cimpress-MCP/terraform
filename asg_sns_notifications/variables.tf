variable "asg_names" {
  type = "string"
  description = "ASG names to attach the notifications to (comma separated list)"
}

variable "sns_topic" {
  type = "string"
  description = "Where to send the notifications"
}