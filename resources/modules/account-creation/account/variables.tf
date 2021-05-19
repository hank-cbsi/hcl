locals {
  accounts    = data.aws_organizations_organization.this.accounts
  account     = [for s in local.accounts : s if s["email"] == var.accountEmail]
}
variable "accountEmail" {
  default = "null"
}
variable "parentOu" {
  
}
variable "accountTags" {
  type = map
}