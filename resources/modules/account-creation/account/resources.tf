resource "aws_organizations_account" "this" {
  name      = replace(var.accountEmail, "@cbsinteractive.com", "")
  email     = var.accountEmail
  parent_id = var.parentOu
  tags      = var.accountTags

  # lifecycle {
  #     ignore_changes = [role_name]
  # }
}

## Return the account ID after the account has been created
output "accountId" {
  value = aws_organizations_account.this.id
}
## Return the account email after the account has been created
output "accountEmail" {
  value = aws_organizations_account.this.email
}
## Return the organization access role
output "orgAccessRole" {
  value = aws_organizations_account.this.role_name
}
