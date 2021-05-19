variable "roleName" {
  
}

variable "roleSessionDuration" {
  default = 43200
}
 
 variable "roleTrustPolicyFile" {
   
 }
  variable "rolePermissionsPolicyFiles" {
   type = list(string)
 }

locals {
  roleTrustPolicyFile = "${var.roleName}-trust.json"
  rolePermissonsPolicyFiles = ["${var.roleName}-permissions.json"]

}

 data "aws_iam_policy_document" "roleTrust" {
#    source_json = file("${path.root}/policies/${local.roleTrustPolicyFile}")
    source_json = file(var.roleTrustPolicyFile)
 }

data "aws_iam_policy_document" "rolePermissions" {
    for_each = toset(var.rolePermissionsPolicyFiles)
        source_json = file(each.key)
 }

