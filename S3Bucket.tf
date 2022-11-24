resource "aws_s3_bucket" "mydevbuckettest10999008" {
  bucket = "mydevbuckettest10999008"
  

}

resource "aws_flow_log" "dev-vpc-flow-log" {
  log_destination      = aws_s3_bucket.mydevbuckettest10999008.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.dev-vpc.vpc_id
  tags = {
    Name = "dev-vpc-flow-log"
  }
}

resource "aws_s3_bucket_logging" "dev-bucket-acc-log" {
  bucket = aws_s3_bucket.mydevbuckettest10999008.id

  target_bucket = aws_s3_bucket.mydevbuckettest10999008.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "dev-bucket-ver-en" {
  bucket = aws_s3_bucket.mydevbuckettest10999008.id
  versioning_configuration {
    status = "Enabled"
    #mfa_delete = "Enabled"
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "dev-bucket-intelli-tier" {
  bucket = aws_s3_bucket.mydevbuckettest10999008.bucket
  name   = "EntireBucket"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}


resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket_server_side_encryption_configuration" "dev-bucket-encr" {
  bucket = aws_s3_bucket.mydevbuckettest10999008.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_policy" "dev-enforce-ssl-po" {
  bucket = aws_s3_bucket.mydevbuckettest10999008.id
  policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "s3:*"
      ],
      "Resource": [
                "${aws_s3_bucket.mydevbuckettest10999008.arn}/*",
                "${aws_s3_bucket.mydevbuckettest10999008.arn}",
      ],
      "Effect": "Deny",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
)
}



resource "aws_s3_bucket" "myprodbuckettest10999008" {
  bucket = "myprodbuckettest10999008"

}

resource "aws_flow_log" "prod-vpc-flow-log" {
  log_destination      = aws_s3_bucket.myprodbuckettest10999008.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.prod-vpc.vpc_id
   tags = {
    Name = "prod-vpc-flow-log"
  }
}

resource "aws_s3_bucket_logging" "prod-bucket-acc-log" {
  bucket = aws_s3_bucket.myprodbuckettest10999008.id

  target_bucket = aws_s3_bucket.myprodbuckettest10999008.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "prod-bucket-ver-en" {
  bucket = aws_s3_bucket.myprodbuckettest10999008.id
  versioning_configuration {
    status = "Enabled"
    #mfa_delete = "Enabled"
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "prod-bucket-intelli-tier" {
  bucket = aws_s3_bucket.myprodbuckettest10999008.bucket
  name   = "EntireBucket"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "prod-bucket-encr" {
  bucket = aws_s3_bucket.myprodbuckettest10999008.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_policy" "prod-enforce-ssl-po" {
  bucket = aws_s3_bucket.myprodbuckettest10999008.id
  policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "s3:*"
      ],
      "Resource": [
                "${aws_s3_bucket.myprodbuckettest10999008.arn}/*",
                "${aws_s3_bucket.myprodbuckettest10999008.arn}",
      ],
      "Effect": "Deny",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
)
}