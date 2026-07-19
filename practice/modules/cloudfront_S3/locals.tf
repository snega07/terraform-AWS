locals {
  tags = {
    name = "Cloudfront_S3",
    Created_by = "Terraform"
  }

  s3_origin_id = "S3-${aws_s3_bucket.cloudFrontS3.id}"
}

