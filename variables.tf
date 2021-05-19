locals {
  policyRoot = "./resources/policies/"
  defaultTags = {
    Environment = var.env,
    BU          = "Sports",
    Repository  = ""
  }
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