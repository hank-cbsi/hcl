variable "accountId" {

}
variable "tempRoleName" {

}
variable "tempRolePolicyArn" {
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}
variable "managementAccountRole" {
  default = "sharedservices-devops"
}
variable "accountAlias" {

}

variable "orgAccessRole" {
  default = "OrganizationAccountAccessRole"
}

variable "teamApplicationID" {
  
}

variable "applicationID" {
  
}

variable "team" {
  
}