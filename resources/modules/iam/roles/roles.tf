resource "aws_iam_role" "this" {
  name                 = var.roleName
  max_session_duration = var.roleSessionDuration
  assume_role_policy   = data.aws_iam_policy_document.roleTrust.json
}
##
# Create the role permissions policy
# resource "aws_iam_policy" "this" {
#   name = "${var.roleName}-permissions"
#   policy = data.aws_iam_policy_document.role-permissions.json
# }
##
# Attach the role's policy to the role
# resource "aws_iam_role_policy_attachment" "this" {
#   policy_arn = aws_iam_policy.sharedservices-devops-rolePermissionsPolicy.arn
#   role       = aws_iam_role.this.name
# }

