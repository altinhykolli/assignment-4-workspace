data "aws_route53_zone" "default" {
    name = local.domain_name
  
}