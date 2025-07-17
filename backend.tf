terraform {
  backend "s3" {
    bucket         = "my-terraform-backend-buket8645123"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

