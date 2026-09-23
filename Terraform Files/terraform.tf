terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "abs1808"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamo_db_table"
  }


}




