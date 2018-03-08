output "stack_output" {
  value = ["${aws_cloudformation_stack.waf_security_automations_alb.outputs}"]
}