locals {
  policyRoot = "./resources/policies/"
  defaultTags = {
    Environment = var.env,
    BU          = "Sports",
    Repository  = "git@github.com:cbs-sports/create-account.git"
  }
}
###############################################################################
## EXPERIMENTAL - Define this variable for roles with multiple policy files
variable "rolestest" {
  type = object(
    {
      role = object(
        {
          roleName        = string,
          roleTrust       = string,
          rolePermissions = list(string)
        }
      )
    }
  )
  default = {
    role = {
      roleName        = "test",
      roleTrust       = "sharedservices-devops-trust.json",
      rolePermissions = ["sharedservices-devops-permissions.json", "DivvyCloud-Prod-Role-policy-p2.json"]
  } }
}
## EXPERIMENTAL Define this variable for roles with multiple policy files
###############################################################################
variable "policyList" {
  default = []

}

variable "env" {

}
variable "team" {

}

variable "region" {

}

variable "trustedPrincipals" {
  type = list(any)
}

variable "email" {

}

variable "parentOu" {

}

variable "tempRoleName" {

}
variable "tempRolePolicyArn" {

}
variable "accountTags" {

}
