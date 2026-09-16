variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog Application key"
  type        = string
  sensitive   = true
}

variable "ip_address" {
  description = "IP address of the EC2 instance to monitor"
  type        = string
}


provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "ec2_cpu" {
  name = "EC2 CPU High - ${var.ip_address}"

  type = "metric alert"

  query = "avg(last_5m):avg:system.cpu.user{host:${var.ip_address}} > 90"

  message = <<-EOT
    EC2 instance ${var.ip_address} has high CPU utilization.

    CPU utilization has exceeded 90% for the configured evaluation period.

    Please investigate the EC2 instance.
  EOT

  monitor_thresholds {
    critical = 90
  }

  notify_no_data    = true
  no_data_timeframe = 10

  include_tags = true

  tags = [
    "terraform:true",
    "monitor_type:ec2",
    "ec2_ip:${var.ip_address}"
  ]
}
