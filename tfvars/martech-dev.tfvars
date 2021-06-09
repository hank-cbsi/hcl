region = "us-east-1"
team = "sharedservices"
env = "prod"
trustedPrincipals = ["509012476596"]
email="i-aws-sports-martech-dev@cbsinteractive.com"

accountTags = {
        Name = "i-aws-sports-martech-dev",
        BU   = "sports"
        Managedby = "Terraform"
}

roles = ["sharedservices-devops", "sharedservices-developer"]
