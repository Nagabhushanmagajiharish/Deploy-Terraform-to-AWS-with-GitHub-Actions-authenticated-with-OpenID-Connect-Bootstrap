
provider "aws" {
  region = "us-east-1"  # or your preferred region
}

resource "aws_s3_bucket" "example" {
  bucket = "bushan-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}