resource "aws_route53_record" "app" {
  count   = local.app_dns_record_count
  zone_id = local.hosted_zone_id
  name    = local.cnames[count.index]
  type    = "A"
  alias {
    name                   = aws_lb.lb[0].dns_name
    zone_id                = aws_lb.lb[0].zone_id
    evaluate_target_health = var.dns_evaluate_target_health
  }
}
