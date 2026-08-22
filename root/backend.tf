terraform {
  backend "s3" {
    bucket = "2-tier-architecture-628270104142-us-east-1-an"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "remote-key"
  }
}