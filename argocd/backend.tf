###-backend

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "backend" {
  bucket_prefix = "local-cluster"

  versioning {
    enabled = false
  }

  force_destroy = true

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "aws_dynamodb_table" "backend_lock" {
  name           = "local-cluster"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}


output "s3_bucket_name" {
  value = aws_s3_bucket.backend.id
}

output "dynamodb_endpoint" {
  value = aws_dynamodb_table.backend_lock.name
}




###-backend only s3

provider "aws" {}

terraform {
  backend "s3" {
    bucket               = "local-cluster"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "kind-template"
    region               = "eu-west-1"
  }
}
