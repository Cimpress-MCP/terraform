variable "dashboard_name" {
  type = "string"
  description = "Cloudwatch's dashboard name"
}

variable "lb_name" {
  type = "string"
  description = "Load Balancer name to monitor"
}

variable "period" {
  type = "string"
  description = "Period to update the chart (in seconds, default 60)"
  default = "60"  
}