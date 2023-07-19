resource "aws_ecr_repository" "foo" {
  name                 = "altin-assignment-4"
  image_tag_mutability = "MUTABLE"
}