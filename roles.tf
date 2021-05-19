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

locals {
  rolePolicyDir = "./resources/policies"
}

variable "roles" {
  type = list(string)
  default = ["mytestrole"]
}

module "roles" {
  source                     = "./resources/modules/iam/roles/"
  for_each                   = toset(var.roles)
  roleName                   = each.key
  roleTrustPolicyFile        = "${local.rolePolicyDir}/${each.key}-trust.json"
  rolePermissionsPolicyFiles = ["${local.rolePolicyDir}/${each.key}-permissions.json"]
}
