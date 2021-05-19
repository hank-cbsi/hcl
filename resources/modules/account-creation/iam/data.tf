terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

data "aws_iam_role" "orgAccessRole" {
  name = var.orgAccessRole
}

output "orgAccessAssumeRolePolicy" {
  value = data.aws_iam_role.orgAccessRole.assume_role_policy

}