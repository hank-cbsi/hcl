resource "aws_iam_role" "this" {
  name                 = var.roleName
  max_session_duration = var.roleSessionDuration
  assume_role_policy   = data.aws_iam_policy_document.roleTrust.json
}

data "aws_iam_policy_document" "roleTrust" {
  source_json = file(var.roleTrustPolicyFile)
}

resource "aws_iam_policy" "rolePermissions" {
  name   = "${var.roleName}-permissions"
  policy = data.aws_iam_policy_document.rolePermissions.json
}

# Attach the role's policy to the role
resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.rolePermissions.arn
  role       = aws_iam_role.this.name
}

data "aws_iam_policy_document" "rolePermissions" {
  source_json = file(var.rolePermissionsPolicyFiles)
}