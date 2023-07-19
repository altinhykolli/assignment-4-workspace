module "web_client" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.0"
  bucket = "altin-assignment-4"
  }