

resource "aws_s3_bucket" "my_bucket" {
  bucket        = var.bucket_name 
  force_destroy = true

  tags = {
    Name        = "Migration Bucket"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    id     = "MoveToStandardIA"
    status = "Enabled"

    filter { prefix = "" }

    transition {
      days          = var.lifecycle_days1
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.lifecycle_days2
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }
  }
}




  
