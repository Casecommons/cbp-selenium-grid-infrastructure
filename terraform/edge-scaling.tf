resource "aws_appautoscaling_target" "edge_target" {
  max_capacity       = var.edge_max_tasks
  min_capacity       = var.edge_min_tasks
  resource_id        = "service/${aws_ecs_cluster.selenium_grid.name}/${aws_ecs_service.edge.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "edge_cpu_scale_out" {
  name               = "${var.app_name}-edge-cpu-scale-out"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.edge_target.resource_id
  scalable_dimension = aws_appautoscaling_target.edge_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.edge_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = var.edge_scale_up 
      metric_interval_lower_bound = 0
    }
    step_adjustment {
      scaling_adjustment          = var.edge_scale_up 
      metric_interval_upper_bound = 0
    }
  }
}

resource "aws_appautoscaling_policy" "edge_cpu_scale_in" {
  name               = "${var.app_name}-edge-cpu-scale-in"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.edge_target.resource_id
  scalable_dimension = aws_appautoscaling_target.edge_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.edge_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = var.edge_min_tasks
      metric_interval_lower_bound = 0
    }
    step_adjustment {
      scaling_adjustment          = var.edge_min_tasks
      metric_interval_upper_bound = 0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "edge_high_cpu" {
    alarm_name = "${aws_ecs_service.edge.name}_high_cpu"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/ECS"
    period = "60"
    statistic = "Maximum"
    threshold = var.edge_cpu_scale_out_threshold

    dimensions = {
        ClusterName = aws_ecs_cluster.selenium_grid.name
        ServiceName = aws_ecs_service.edge.name
    }

    alarm_actions = [aws_appautoscaling_policy.edge_cpu_scale_out.arn]

}

resource "aws_cloudwatch_metric_alarm" "edge_low_cpu" {
    alarm_name = "${aws_ecs_service.edge.name}_low_cpu"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "15"
    metric_name = "CPUUtilization"
    namespace = "AWS/ECS"
    period = "60"
    statistic = "Maximum"
    threshold = var.edge_cpu_scale_in_threshold
    treat_missing_data = "notBreaching"
    dimensions = {
        ClusterName = aws_ecs_cluster.selenium_grid.name
        ServiceName = aws_ecs_service.edge.name
    }
    alarm_actions = [aws_appautoscaling_policy.edge_cpu_scale_in.arn]
}