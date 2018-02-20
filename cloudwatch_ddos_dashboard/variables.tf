variable "dashboard_name" {
  type = "string"
  description = "Cloudwatch's dashboard name"
}

variable "asg_name" {
  type = "string"
  description = "ASG name to monitor"
}

variable "period" {
  type = "string"
  description = "Period to update the chart (in seconds, default 60)"
  default = "60"  
}