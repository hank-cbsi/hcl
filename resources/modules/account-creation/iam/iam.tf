resource "aws_iam_role" "this" {
  name               = var.tempRoleName
  max_session_duration = 43200
  assume_role_policy = <<EOF
{           
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Action" : "sts:AssumeRole",
            "Effect" : "Allow",
            "Principal" : {
                "AWS" :  "arn:aws:iam::969127486896:root"
            }
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "this" {
    role = aws_iam_role.this.name
    policy_arn = var.tempRolePolicyArn
  
}

resource "aws_iam_account_alias" "alias" {
  account_alias = var.accountAlias
}


resource "aws_iam_saml_provider" "teamSaml-idp" {
    name    = "${var.team}-idp"
    saml_metadata_document = templatefile("${path.module}/metadata.tpl", {APPLICATIONID = var.teamApplicationID})
}

resource "aws_iam_saml_provider" "saml-idp" {
    name    = "sports-okta-id-provider"
    saml_metadata_document = templatefile("${path.module}/metadata.tpl", {APPLICATIONID = var.applicationID})
}