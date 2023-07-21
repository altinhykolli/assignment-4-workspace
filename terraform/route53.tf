module "web_client_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.10.2"

  zone_id = local.hosted_zone_id

  records = [
    {
      name    = "altin"
      type    = "CNAME"
      ttl     = 300
      records = [module.web_client_cdn.cloudfront_distribution_domain_name]
    }
  ]
}