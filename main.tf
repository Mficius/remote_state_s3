resource "aws_s3_bucket" "remote_state" {
    bucket = "${var.prefix}-remote-state-${var.environment}"
    force_destroy = false

    lifecycle {
        prevent_destroy = true
    }

    tags = {
        Name = "${var.prefix}-remote-state-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.remote_state.id
  acl    = "authenticated-read"
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}