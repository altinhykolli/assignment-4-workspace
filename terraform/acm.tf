module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"
  domain_name  = local.domain_name
  zone_id      = local.hosted_zone_id
  subject_alternative_names = local.alternative_domain_names
  wait_for_validation = true
}