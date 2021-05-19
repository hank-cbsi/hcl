##############################################################################
# Create the account
provider "aws" {
  alias   = "orgmaster"
  profile = "org-prod"
  region  = var.region
  default_tags {
    tags = local.defaultTags
  }
}
##
module "account_creation" {
  source = "./resources/modules/account-creation/account"
  providers = {
    aws = aws.orgmaster
  }
  accountEmail = var.email
  parentOu     = var.parentOu
  accountTags  = var.accountTags
}

##############################################################################
# Create resources in the newly created account using a different provider
provider "aws" {
  alias = "orgToClient"
  # profile = "${var.team}-${var.env}"
  profile = "org-prod"
  region  = var.region
  assume_role {
    role_arn = "arn:aws:iam::${module.account_creation.accountId}:role/OrganizationAccountAccessRole"
  }
  default_tags {
    tags = local.defaultTags
  }
}

# Create a role and an alias in the new account
##
module "orgIam" {
  source = "./resources/modules/account-creation/iam/"
  providers = {
    aws = aws.orgToClient
  }
  accountId         = module.account_creation.accountId
  tempRoleName      = var.tempRoleName
  tempRolePolicyArn = var.tempRolePolicyArn
  accountAlias      = replace(module.account_creation.accountEmail, "@cbsinteractive.com", "")
  team              = var.team
  applicationID      = "THISISATESTAPPICATION"
  teamApplicationID = "THISISANOTHERTESTAPPLICATION"
  
}


####################################################################
## this is test code
# output "test" {
#   value = module.orgIam.orgAccessAssumeRolePolicy
# }

# data "aws_iam_policy_document" "this" {
# source_json   = module.orgIam.orgAccessAssumeRolePolicy

# statement {
#     sid = "AllowSharedServices"
#     actions = ["sts:AssumeRole"]
#     effect = "Allow"
#     principals {
#       type = "AWS"
#       identifiers = ["arn:aws:iam::969127486896:root"]
#     }
#   }
# }
## this is test code
####################################################################
