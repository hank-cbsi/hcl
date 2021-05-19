# provider "aws" {
#   profile = "${var.team}-${var.env}"
#   region  = var.region
# }

 terraform {
    
     backend "s3" {
        bucket = "i-aws-sports-sharedservices-terraform-state"
        key = "hank/state/accounts.tf"
        region = "us-east-1"
        profile = "sharedservices-prod"
    }
 }



