resource "aws_cloudwatch_dashboard" "main" {
   dashboard_name = "${var.dashboard_name}"
   count = "${var.app_lb ? 1 : 0}"

   dashboard_body = <<EOF
   {
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 21,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": true,
                "metrics": [
                    [ "AWS/ELB", "SurgeQueueLength", "LoadBalancerName", "${var.lb_name}", { "period": "${var.period}" } ],
                    [ ".", "RequestCount", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "BackendConnectionErrors", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "HTTPCode_ELB_5XX", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "Latency", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "HTTPCode_Backend_3XX", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "HTTPCode_Backend_4XX", ".", ".", { "stat": "Sum", "period": "${var.period}" } ]
                ],
                "region": "${data.aws_region.current.name}",
                "start": "-P7D",
                "end": "P0D"
            }
        }
    ]
  }
  EOF
}

resource "aws_cloudwatch_dashboard" "main_alb" {
   dashboard_name = "${var.dashboard_name}"
   count = "${var.app_lb ? 1 : 0}"

   dashboard_body = <<EOF
   {
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 21,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": true,
                "metrics": [
                    [ "AWS/ApplicationELB", "SurgeQueueLength", "LoadBalancer", "${var.lb_name}", { "period": "${var.period}" } ],
                    [ ".", "RequestCount", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "ActiveConnectionCount", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "HTTPCode_ELB_4XX_Count", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "TargetResponseTime", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "HTTPCode_Target_3XX_Count", ".", ".", { "stat": "Sum", "period": "${var.period}" } ],
                    [ ".", "HTTPCode_Target_4XX_Count", ".", ".", { "stat": "Sum", "period": "${var.period}" } ]
                ],
                "region": "${data.aws_region.current.name}",
                "start": "-P7D",
                "end": "P0D"
            }
        }
    ]
  }
  EOF
}