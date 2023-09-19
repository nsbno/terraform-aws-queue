terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "queue" {
  source = "../"

  name               = "my-application-input"
  visibility_timeout = 30

  subscribe_sns_arns = ["arn:aws:sns:us-east-1:123456789012:some-topic"]
}
