resource "aws_s3_bucket" "altin-assignment" {
  bucket = "altin-assignment-4"

  tags = {
    Name = "Altin Assignment 4"
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_cloudfront_origin_access_identity" "my_identity" {
  comment = "CloudFront Origin Access Identity for altin-assignment-4"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.altin-assignment.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.my_identity.iam_arn
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.altin-assignment.arn}/*",
      },
    ],
  })
}
