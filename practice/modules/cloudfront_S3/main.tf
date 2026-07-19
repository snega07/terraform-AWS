resource "aws_s3_bucket" "cloudFrontS3" {
  bucket = var.bucket_name
  tags = local.tags

}

resource "aws_s3_bucket_public_access_block" "cloudFrontS3" {
  bucket = aws_s3_bucket.cloudFrontS3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = aws_s3_bucket.cloudFrontS3.id
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Principal": {
        Service: "cloudfront.amazonaws.com"
      },
      "Action": [
        "s3:GetObject","s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::${aws_s3_bucket.cloudFrontS3.bucket}}/*"
    }
  ]

})
}

resource "aws_s3_object" "object" {
  bucket = "cloudFrontS3"

  for_each = fileset("${path.module}/www","**/*")
  key    = each.value
  source = "${path.module}/www/${each.value}"
  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "json" = "application/json",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml",
    "ico"  = "image/x-icon",
    "txt"  = "text/plain"
  },split(".",each.value)[length(split(".",each.value))-1],
  "application/octet-stream")

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.module}/www/${each.value}")
}


