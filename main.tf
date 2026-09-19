terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://localhost:4566"
    sqs      = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "devops-interview-demo-bucket"
}

resource "aws_sqs_queue" "demo_queue" {
  name                      = "devops-interview-queue"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
}

output "s3_bucket_name" {
  value = aws_s3_bucket.demo_bucket.id
}

output "sqs_queue_url" {
  value = aws_sqs_queue.demo_queue.id
}
