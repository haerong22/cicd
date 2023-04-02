resource "aws_iam_user" "s3_user" {
  name = "s3_user"
}

resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

resource "aws_iam_user_policy_attachment" "s3_user_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  user = aws_iam_user.s3_user.name
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "key-store-bucket"
}

resource "aws_s3_bucket_acl" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  acl = "private"
}
