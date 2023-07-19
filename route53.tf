resource "aws_route53_zone" "main" {
  name = "appstellar.training"
}

resource "aws_route53_record" "my_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "altin-assignment-4.appstellar.training"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}