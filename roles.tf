######################################
## Creates roles based on a list of role names.
## Create a provider that runs as a temporary role in the target account
provider "aws" {
  profile = "sharedservices-prod"
  region  = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${module.account_creation.accountId}:role/tempRole"
  }
  default_tags {
    tags = local.defaultTags
  }
}

## Define local variables
locals {
  rolePolicyDir = "./resources/policies"
}
## Define variables
variable "roles" {
  type = list(string)
}

## Create resources from the source module
module "roles" {
  source                     = "./resources/modules/iam/roles/"
  for_each                   = toset(var.roles)
  roleName                   = each.key
  roleTrustPolicyFile        = "${local.rolePolicyDir}/${each.key}-trust.json"
  rolePermissionsPolicyFiles = "${local.rolePolicyDir}/${each.key}-permissions.json"
  depends_on = [
    module.orgIam.tempRoleName
  ]
}
