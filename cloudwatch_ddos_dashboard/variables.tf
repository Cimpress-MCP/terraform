variable "dashboard_name" {
  type = "string"
  description = "Cloudwatch's dashboard name"
}

variable "lb_name" {
  type = "string"
  description = "Load Balancer name to monitor"
}

variable "app_lb" {
  type = "string"
  description = "Write here 'true' if you're attaching this dashboard to an Application Load Balaner rather than a Classic Load Balaner (default 'false')"
  default = false
}

variable "app_elb" {
  type = "string"
  default = "AWS/ApplicationELB"
}

variable "elb" {
  type = "string"
  default = "AWS/ELB"
}


variable "period" {
  type = "string"
  description = "Period to update the chart (in seconds, default 60)"
  default = "60"  
}