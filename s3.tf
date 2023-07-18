data "aws_vpc" "this" {
  tags = {
    Environment= "dev"
  }
}

resource "aws_s3_bucket" "static_website" {
  bucket = "altin-assignment-4.appstellar.training"

  website {
    index_document = "index.html"
  }

  tags = {
    Name = "Altin Assignment 4 Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_website.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect  = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}
