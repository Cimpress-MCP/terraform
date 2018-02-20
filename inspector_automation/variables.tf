variable "name" {
	type = "string"
	description = "Unique name"
}

variable "inspector_tag" {
	type = "string"
	description = "Inspector tag to use"
}

variable "template_duration" {
	type = "string"
	description = "How long the assessment template should run"
}

variable "rules_package" {
	type = "map"
	description = "Inspector rules package (default: all)"
	default = {
		eu-west-1 = "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-SnojL3Z6,arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-lLmwe1zd,arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-sJBhCr0F,arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-ubA5XvBh"
		us-west-1 = "arn:aws:inspector:us-west-1:166987590008:rulespackage/0-TKgzoVOa,arn:aws:inspector:us-west-1:166987590008:rulespackage/0-byoQRFYm,arn:aws:inspector:us-west-1:166987590008:rulespackage/0-xUY8iRqX,arn:aws:inspector:us-west-1:166987590008:rulespackage/0-yeYxlt0x"
		us-west-2 = "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p,arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc,arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ,arn:aws:inspector:us-west-2:758058086616:rulespackage/0-vg5GGHSD"
		us-east-1 = "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-R01qwB5Q,arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gBONHN9h,arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gEjTy7T7,arn:aws:inspector:us-east-1:316112463485:rulespackage/0-rExsr2X8"
		us-east-2 = "arn:aws:inspector:us-east-2:646659390643:rulespackage/0-AxKmMHPX,arn:aws:inspector:us-east-2:646659390643:rulespackage/0-JnA8Zp85,arn:aws:inspector:us-east-2:646659390643:rulespackage/0-UCYZFKPV,arn:aws:inspector:us-east-2:646659390643:rulespackage/0-m8r61nnh"
		eu-central-1 = "arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-0GMUM6fg,arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-ZujVHEPB,arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-nZrAVuv8,arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-wNqHa8M9"
		ap-northeast-1 = "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-7WNjqgGu,arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-bBUQnxMq,arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-gHP9oWNT,arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-knGBhqEu"
		ap-northeast-2 = "arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-2WRpmi4n,arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-PoGHMznc,arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-PoYq7lI7,arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-T9srhg1z"
		ap-southeast-2 = "arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-D5TGAxiR,arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-P8Tel2Xj,arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-Vkd2Vxjq,arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-asL6HRgN"
		ap-south-1  = "arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-EhMQZy6C,arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-LqnJE9dO,arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-PSUlX14m,arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-fs0IZZBj"
	}
}

variable "cloudwatch_sched_rule" {
	type = "string"
	description = "Cloudwatch scheduled event rule"
}