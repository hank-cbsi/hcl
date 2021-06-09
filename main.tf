# provider "aws" {
#   profile = "${var.team}-${var.env}"
#   region  = var.region
# }

terraform {

  backend "s3" {

  }
}



