# AWS WAF Module

This Terraform Module is used to spin up an AWS Web Application Firewall, based on [AWS WAF Security Automations](https://aws.amazon.com/en/answers/security/aws-waf-security-automations/).

Due to the current shortage of Terraform's WAF resources/data sources, this module uses an [AWS CloudFormation Template for Application Load Balancers](https://docs.aws.amazon.com/solutions/latest/aws-waf-security-automations/template.html), which has been modified to include also a WebACLAssociation resource for attaching the WebACL to the Application Load Balanced specified as input parameters.

You can see the official AWS documentation for this solution [here](https://docs.aws.amazon.com/solutions/latest/aws-waf-security-automations/overview.html)

## Usage

Module Input Variables
----------------------

- `name` - The service for which the WAF is deployed
- `accesslogbucket` - The S3 bucket where the ALB access logs are written
- `sqlinjection` - Enable SQL Injection Protection
- `xss` - Enable XSS Protection
- `httpflood` - Enable HTTP Flood Protection
- `scansprobe` - Enable Scans and Probes Protection
- `reputationlists` - Enable blocking requests from 3rd-party reputation lists (spamhaus, torprojects, emergingthreats)
- `badbot` - Enable BadBot and scrapers Protection
- `httprequeststhreshold` - If you chose yes for the Activate HTTP Flood Protection parameter, enter the maximum acceptable requests per 5-minute period per IP address. Minimum value of 2000.
- `scansprobeserrorthreshold` - If you chose yes for the Activate Scanners & Probes Protection parameter, enter the maximum acceptable bad requests per minute per IP
- `wafblockperiod` - If you chose yes for the Activate Scanners & Probes Protection parameters, enter the period (in minutes) to block applicable IP addresses
- `albid` - ID of the ALB to associate the WAF with

Here below an example of how to call this module:

```
terraform {
  backend "s3" {
    # must run: $ terraform init -backend-config 'key=waf.tfstate'
    bucket = "terraform-tfstate-files"
    region = "eu-west-1" 
  }
}

provider "aws" {
  region = "eu-west-1"
  version = "~> 1.5"
}


module "waf_setup" {
  source = "git::https://cimpress.githost.io/ips/terraform_modules/waf_setup.git"
  name = "MyWAFTest-WAF"
  squad = "IPS-SET"
  project = "MyWAFTest"
  accesslogbucket = "MyTestBucketName"
  sqlinjection = "yes"
  xss = "yes"
  httpflood = "yes"
  scansprobe = "yes"
  reputationlists = "yes"
  badbot = "yes"
  httprequeststhreshold = "2000"
  scansprobeserrorthreshold = "50"
  wafblockperiod = "240"
  albid = "YOUR ALB ID"
}

```

## Output
-----
 - `stack_output` - The output of the CloudFormation Stack for creating the WAF, containing all details.