module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "altin-assignment-4"
  acl    = "private"
  }