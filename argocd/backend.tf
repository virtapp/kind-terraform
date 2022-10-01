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






###-backend create s3 manually 

provider "aws" {}

terraform {
  backend "s3" {
    bucket               = "local-cluster"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "kind-template"
    region               = "eu-west-1"
  }
}





###-backend create s3 automaticly 

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = "local-cluster-office"
  versioning {
    enabled = true
  }

  force_destroy = true

  // lifecycle {
  //   prevent_destroy = true
  // }
}





###-backend local automaticly 

terraform {
  backend "local" {
    workspace_dir = "./terraform-state"
    path = "state/development.tfstate"
  }
}

