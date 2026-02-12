provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name
}

resource "aws_s3_object" "object" {
  bucket = module.s3_bucket.bucket_name
  key    = "uploads/hello.txt"
  source = "${path.module}/files/hello.txt"
  etag   = filemd5("${path.module}/files/hello.txt")
}

resource "aws_s3_bucket_public_access_block" "bpa" {
  bucket = module.s3_bucket.bucket_name

  block_public_acls = true
}
