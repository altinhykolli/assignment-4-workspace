module "web_client_cdn" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.2.1"
  #aliases = [""]

  comment         = "CDN for web-client"
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"

  create_origin_access_identity = true
  origin_access_identities = {
    s3_web_client = "Web Client Bucket"
  }


  origin = {
    s3_web_client = {
      domain_name = module.s3_bucket_bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_web_client"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id           = "web_client"
    viewer_protocol_policy     = "allow-all"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }



  #   viewer_certificate = {
  #     acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
  #     ssl_support_method  = "sni-only"
  #   }
}