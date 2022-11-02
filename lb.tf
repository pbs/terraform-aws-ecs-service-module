resource "aws_lb" "lb" {
  count           = local.create_lb ? 1 : 0
  name            = local.load_balancer_name
  subnets         = local.subnets
  security_groups = local.lb_security_groups
  idle_timeout    = var.idle_timeout

  internal = local.internal

  load_balancer_type = var.load_balancer_type

  tags = merge(
    local.tags,
    { Name = "${local.load_balancer_name} LB" },
  )
}

## HTTP Listeners
resource "aws_lb_listener" "http" {
  count             = local.only_create_http_listener ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].id
  port              = local.http_port
  protocol          = "HTTP"

  # We 403 by default, unless one of the application rules below is met.

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "403"
    }
  }
}

resource "aws_lb_listener" "http_redirect" {
  count             = local.create_https_listeners ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].id
  port              = local.http_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = local.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

## HTTPS Listener
resource "aws_lb_listener" "https" {
  count             = local.create_https_listeners ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].id
  port              = local.https_port
  protocol          = "HTTPS"
  certificate_arn   = local.acm_arn
  ssl_policy        = var.alb_ssl_policy

  # We 403 by default, unless one of the application rules below is met.

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "403"
    }
  }

  depends_on = [
    aws_lb_target_group.target_group
  ]
}

## NLB Listener
resource "aws_lb_listener" "nlb" {
  count             = local.create_nlb_listeners ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].id
  port              = local.https_port
  protocol          = var.nlb_protocol
  certificate_arn   = local.acm_arn
  alpn_policy       = var.alpn_policy
  ssl_policy        = var.nlb_ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }

  depends_on = [
    aws_lb_target_group.target_group
  ]
}

resource "aws_lb_target_group" "target_group" {
  count       = local.create_target_group ? 1 : 0
  name        = local.target_group_name
  port        = var.container_port
  protocol    = local.container_protocol
  vpc_id      = local.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = var.healthcheck_healthy_threshold
    unhealthy_threshold = var.healthcheck_unhealthy_threshold
    timeout             = local.healthcheck_timeout
    path                = var.healthcheck_path
    protocol            = local.healthcheck_protocol
    interval            = var.healthcheck_interval
    matcher             = local.healthcheck_matcher
  }

  tags = merge(local.tags, { "Name" = "${local.target_group_name} target group" })
}

## Application Rule

resource "aws_lb_listener_rule" "http_application_rule" {
  count        = local.http_application_rule_count
  listener_arn = aws_lb_listener.http[0].arn
  priority     = local.route_priority + count.index

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }

  condition {
    host_header {
      values = [element(local.aliases, count.index)]
    }
  }
}

resource "aws_lb_listener_rule" "https_application_rule" {
  count        = local.https_application_rule_count
  listener_arn = aws_lb_listener.https[0].arn
  priority     = local.route_priority + count.index

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }

  condition {
    host_header {
      values = [element(local.aliases, count.index)]
    }
  }
}
