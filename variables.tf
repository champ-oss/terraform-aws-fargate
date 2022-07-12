variable "name" {
  description = "Unique identifier to be applied to all resources"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "wait_for_steady_state" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#wait_for_steady_state"
  type        = bool
  default     = true
}

variable "port" {
  description = "Port number of the service running inside your container"
  type        = number
  default     = 80
}

variable "listener_port" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_listener#port"
  type        = number
  default     = 443
}

variable "security_groups" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#security_groups"
  type        = list(string)
  default     = []
}

variable "execution_role_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#execution_role_arn"
  type        = string
  default     = null
}

variable "enable_execute_command" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#enable_execute_command"
  type        = bool
  default     = false
}

variable "image" {
  description = "https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definition_image"
  type        = string
  default     = "httpd"
}

variable "cpu" {
  description = "https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html"
  type        = number
  default     = 256
}

variable "memory" {
  description = "https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html"
  type        = number
  default     = 512
}

variable "environment" {
  description = "Map of configuration values to be converted into ECS native format"
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-parameters.html#secrets-envvar-parameters"
  type        = map(string)
  default     = {}
}

#################################################
# Healthcheck
#################################################

variable "healthcheck" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#path"
  type        = string
  default     = "/"
}

variable "matcher" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#matcher"
  type        = string
  default     = "200,301,302"
}

variable "health_check_grace_period_seconds" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#health_check_grace_period_seconds"
  default     = 30
  type        = number
}

variable "deregistration_delay" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#deregistration_delay"
  default     = 30
  type        = number
}
variable "healthy_threshold" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#healthy_threshold"
  default     = 2
  type        = number
}

variable "unhealthy_threshold" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#unhealthy_threshold"
  default     = 10
  type        = number
}

variable "interval" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#interval"
  default     = 15
  type        = number
}

variable "timeout" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#timeout"
  default     = 5
  type        = number
}

#################################################
# Logging
#################################################

variable "filter_pattern" {
  description = "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html#extract-log-event-values"
  type        = string
  default     = null
}

variable "slack_url" {
  description = "Slack webhook used for CloudWatch log alerts"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group#retention_in_days"
  type        = number
  default     = 365
}

#################################################
# Auto Scaling
#################################################

variable "max_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#max_capacity"
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#min_capacity"
  type        = number
  default     = 1
}

variable "autoscaling_target_cpu" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy#target_value"
  type        = number
  default     = 70
}

variable "scale_in_cooldown" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy#scale_in_cooldown"
  type        = number
  default     = 60
}

variable "scale_out_cooldown" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy#scale_out_cooldown"
  type        = number
  default     = 60
}

#################################################
# Data
#################################################

variable "vpc_tags" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc#tags"
  type        = map(string)
  default     = { type = "vega" }
}

variable "subnet_tags" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets#tags"
  type        = map(string)
  default     = { type = "vega-private" }
}

variable "sg_tags" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group#tags"
  type        = map(string)
  default     = { type = "vega" }
}

variable "lb_tags" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb#tags"
  type        = map(string)
  default     = { type = "vega" }
}
