locals {
  s3_origin_id = "myS3Origin"
  domain_name = "altin-assignment-4.s3.eu-central-1.amazonaws.com"
}

resource "aws_acm_certificate" "my_certificate" {
  domain_name       = local.domain_name
  validation_method = "DNS"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = local.domain_name
    origin_id                = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.my_identity.cloudfront_access_identity_path
    }
  }

  enabled                   = true
  is_ipv6_enabled           = true
  http_version              = "http2"
  price_class               = "PriceClass_200"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

    tags = {
    Environment = "dev"
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.my_certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
