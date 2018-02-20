resource "aws_lambda_function" "inspector_lambda" {
  filename         = "${path.module}/inspector-scheduled-run.zip"
  function_name    = "inspector_scheduled_run-${var.name}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("${path.module}/inspector-scheduled-run.zip"))}"
  runtime          = "nodejs4.3"

  environment {
    variables = {
      assessmentTemplateArn = "${aws_inspector_assessment_template.inspector_atmp.arn}"
    }
  }
}

resource "aws_cloudwatch_event_rule" "cw_event_rule" {
    name = "cw_event_rule-${var.name}"
    description = "Fires every X"
    schedule_expression = "${var.cloudwatch_sched_rule}"
}

resource "aws_cloudwatch_event_target" "lambda_inspector_cw_event_rule" {
    rule = "${aws_cloudwatch_event_rule.cw_event_rule.name}"
    target_id = "inspector_lambda"
    arn = "${aws_lambda_function.inspector_lambda.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
    statement_id = "AllowExecutionFromCloudWatch-${var.name}"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.inspector_lambda.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.cw_event_rule.arn}"
}