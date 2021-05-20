resource "aws_iam_role" "this" {
  name                 = var.roleName
  max_session_duration = var.roleSessionDuration
  assume_role_policy   = data.aws_iam_policy_document.roleTrust.json
}
##

data "aws_iam_policy_document" "roleTrust" {
  source_json = file(var.roleTrustPolicyFile)
}

resource "aws_iam_policy" "rolePermissions" {
  count  = length(data.aws_iam_policy_document.rolePermissions)
  name   = "${var.roleName}-permissions-${count.index}"
  policy = data.aws_iam_policy_document.rolePermissions[count.index].json

}

# Attach the role's policy to the role
resource "aws_iam_role_policy_attachment" "this" {
  count      = length(aws_iam_policy.rolePermissions)
  policy_arn = aws_iam_policy.rolePermissions[count.index].arn
  role       = aws_iam_role.this.name
}


data "aws_iam_policy_document" "rolePermissions" {
  count       = length(var.rolePermissionsPolicyFiles)
  source_json = file(element(var.rolePermissionsPolicyFiles, count.index))
}
