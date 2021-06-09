region = "us-east-1"
team = "sharedservices"
env = "prod"
trustedPrincipals = ["509012476596"]
email="i-aws-sports-martech@cbsinteractive.com"

accountTags = {
        Name = "i-aws-sports-martech",
        BU   = "sports"
        Managedby = "Terraform"
}

roles = ["sharedservices-devops", "sharedservices-developer"]
