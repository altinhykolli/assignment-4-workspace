resource "aws_cloudfront_origin_access_control" "web_client" {
  name                              = "altin_web_client_oac"
  description                       = "Grant access to s3 media bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

module "web_client_cdn" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.2.1"
  #aliases = [""]

  comment         = "CDN for web-client"
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"

default_root_object = "index.html"

  create_origin_access_identity = false

 origin = {
    web_client = {
      domain_name              = module.web_client.s3_bucket_bucket_domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.web_client.id
    }
  }

default_cache_behavior = {
    target_origin_id       = "web_client"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    min_ttl     = 1
    default_ttl = 86400
    max_ttl     = 31536000
  }


 
 
  #   viewer_certificate = {
  #     acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
  #     ssl_support_method  = "sni-only"
  #   }
}