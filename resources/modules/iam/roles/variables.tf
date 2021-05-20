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



