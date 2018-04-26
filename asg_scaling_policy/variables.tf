variable "name" {
  type = "string"
  description = "Name to assign to all resources"
}

variable "asg_name" {
  type = "string"
  description = "ASG name to apply the rules to"
}

variable "metric_name" {
  type = "string"
  description = "The metric name to use"
}

variable "namespace" {
  type = "string"
  description = "The namespace where the metric name resides"
}

variable "statistic_type" {
  type = "string"
  description = "Type of statistic (average, minimum, maximum)"
} 

variable "cooldown" {
  type = "string"
  description = "Cooldown period (in seconds, default 300)"
  default = "300"
}

variable "scaling_adjustment_up" {
  type = "string"
  description = "Number of instances to scale up (default 1)"
  default = "1"
}

variable "scaling_adjustment_down" {
  type = "string"
  description = "Number of instances to scale down (default 1)"
  default = "-1"
}

variable "evaluation_periods" {
  type = "string"
  description = "How many times the 'period' should be checked (default is 3)"
  default = "3"
}

variable "period" {
  type = "string"
  description = "Period (in seconds, default 60)"
  default = "60"
}

variable "threshold_up" {
  type = "string"
  description = "Threshold which triggers the autoscaling policy (default 80)"
  default = "80"
}

variable "threshold_down" {
  type = "string"
  description = "Threshold which triggers the autoscaling policy (default 10)"
  default = "10"
}