terraform {
  required_version = ">= 1.0"
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
  
  # CRITICAL: Forces path-style URLs (http://127.0.0.1:4566/bucket) instead of subdomains
  s3_use_path_style           = true 

  endpoints {
    s3  = "http://127.0.0.1:4566"
    sqs = "http://127.0.0.1:4566"
  }
}

# AWS S3 Bucket (Equivalent to GCP Cloud Storage Bucket)
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "devops-interview-demo-bucket"
}

# AWS SQS Queue (Equivalent to GCP Pub/Sub Subscription/Queue)
resource "aws_sqs_queue" "demo_queue" {
  name                      = "devops-interview-queue"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.demo_bucket.id
  description = "The name of the created S3 bucket"
}

output "sqs_queue_url" {
  value       = aws_sqs_queue.demo_queue.id
  description = "The URL of the created SQS queue"
}
