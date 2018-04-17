variable "accesslogbucket" {
  type = "string"
  description = "ALB access log bucket"
}

variable "sqlinjection" {
  type = "string"
  description = "Enable SQL Injection Protection"
  default = "yes"
}

variable "xss" {
  type = "string"
  description = "Enable XSS Protection"
  default = "yes"
}

variable "httpflood" {
  type = "string"
  description = "Enable HTTP Flood Protection"
  default = "yes"
}

variable "scansprobe" {
  type = "string"
  description = "Enable Scans and Probes Protection"
  default = "yes"
}

variable "reputationlists" {
  type = "string"
  description = "Enable blocking requests from 3rd-party reputation lists (spamhaus, torprojects, emergingthreats)"
  default = "yes"
}

variable "badbot" {
  type = "string"
  description = "Enable BadBot and scrapers Protection"
  default = "yes"
}

variable "httprequeststhreshold" {
  type = "string"
  description = "If you chose yes for the Activate HTTP Flood Protection parameter, enter the maximum acceptable requests per FIVE-minute period per IP address. Minimum value of 2000. If you chose to deactivate this protection, ignore this parameter."
  default = "2000"
}

variable "scansprobeserrorthreshold" {
  type = "string"
  description = "If you chose yes for the Activate Scanners & Probes Protection parameter, enter the maximum acceptable bad requests per minute per IP. If you chose to deactivate Scanners & Probes protection, ignore this parameter."
  default = "50"
}

variable "wafblockperiod" {
  type = "string"
  description = "If you chose yes for the Activate Scanners & Probes Protection parameters, enter the period (in minutes) to block applicable IP addresses. If you chose to deactivate this protection, ignore this parameter."
  default = "240"
}

variable "albid" {
  type = "string"
  description = "ID of the ALB to associate the WAF with"
}

variable "name" {
  type = "string"
  description = "CloudFormation Stack Name"
}

variable "extra_tags" {
  type = "map"
  description = "A map of additional tags to add to ELBs and SGs. Each element in the map must have the key = value format"

  # example:
  # extra_tags = {
  #   "Environment" = "Dev",
  #   "Squad" = "Ops"
  # }

  default = {}
}

/*
variable "alb_ids" {
  type = "list"
  description = "ID of the ALB to associate the WAF WebACL with"
}
*/