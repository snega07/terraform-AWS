variable "bucket_name" {
  type = string
  description = "The name of the bucket"
  default = "cloudfront-s3"

  validation {
    condition = length(var.bucket_name)>3 &&  can(regex("^[a-z0-9-]+$", var.bucket_name))
    error_message = "Give valid Bucket Name, only lowercase alphanumeric characters and hyphens allowed"
  }
}