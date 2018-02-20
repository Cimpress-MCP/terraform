resource "aws_inspector_resource_group" "inspector_rg" {
  tags {
    Inspector = "${var.inspector_tag}"
  }
}

resource "aws_inspector_assessment_target" "inspector_at" {
  name               = "assessmentarget-${var.name}"
  resource_group_arn = "${aws_inspector_resource_group.inspector_rg.arn}"
}

resource "aws_inspector_assessment_template" "inspector_atmp" {
  name       = "assessmenttemplate-${var.name}"
  target_arn = "${aws_inspector_assessment_target.inspector_at.arn}"
  duration   = "${var.template_duration}"

  rules_package_arns = ["${split(",", lookup(var.rules_package, data.aws_region.current.name))}"]
}