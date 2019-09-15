data "aws_caller_identity" "current" {}

resource "random_string" "random" {
  length = 16
  special = true
  override_special = "/@\" 
}

resource "aws_dynamodb_table" "locking" {
  name           = "${data.aws_caller_identity.current.account_id}-${random_string.random.result}"
  read_capacity  = "20"
  write_capacity = "20"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "state" {
  bucket = "${data.aws_caller_identity.current.account_id}-${random_string.random.result}"
  region = "${local.region}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

output "BACKEND_BUCKET_NAME" {
  value = "${aws_s3_bucket.state.bucket}"
}

output "BACKEND_TABLE_NAME" {
  value = "${aws_dynamodb_table.locking.name}"
}

output "BACKEND_REGION" {
  value = "${local.region}"
}