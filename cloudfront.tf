locals {
  s3_origin_id = "S3-Website"
  cdn_domain = "altin-assignment-4.appstellar.training"
  zone_name = "appstellar.training"
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Allow OAI to access S3 Bucket"
}

resource "aws_acm_certificate" "cloudfront_cert" {
  domain_name       = local.cdn_domain
  validation_method = "DNS"

  tags = {
    Name = "CloudFront Certificate"
  }
}

resource "aws_route53_zone" "main" {
  name = local.zone_name
}

resource "aws_route53_record" "subdomain" {
  zone_id = aws_route53_zone.main.zone_id
  name    = local.cdn_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.static_website.website_endpoint
    origin_id   = "S3-Website"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "assignment4"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "Altin CDN"
    Environment = "Dev"
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cloudfront_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}
