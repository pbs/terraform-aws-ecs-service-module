resource "aws_appautoscaling_target" "autoscaling_target" {
  resource_id        = "service/${local.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  min_capacity       = local.min_capacity
  max_capacity       = local.max_capacity
}

resource "aws_appautoscaling_policy" "scale_up_policy" {
  name               = "${local.name}-scale-up-policy"
  resource_id        = "service/${local.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  service_namespace = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_up_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_up_adjustment
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down_policy" {
  name               = "${local.name}-scale-down-policy"
  resource_id        = "service/${local.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  service_namespace = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_down_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_down_adjustment
    }
  }
}

# these two alarms are essentially an OR for scaling up - either will trigger scaling
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${local.name}-cpu-high"
  alarm_description   = "This alarm monitors ${local.name} CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_up_cpu_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_up_policy.arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm CPU High" },
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "${local.name}-memory-high"
  alarm_description   = "This alarm monitors ${local.name} web memory utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_up_memory_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_up_policy.arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm Memory High" },
  )
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${local.name}-cpu-low"
  alarm_description   = "This alarm monitors ${local.name} web CPU utilization for scaling down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_down_cpu_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_down_policy.arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm CPU Low" },
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  alarm_name          = "${local.name}-memory-low"
  alarm_description   = "This alarm monitors ${local.name} web memory utilization for scaling down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_down_memory_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_down_policy.arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm Memory Low" },
  )
}
