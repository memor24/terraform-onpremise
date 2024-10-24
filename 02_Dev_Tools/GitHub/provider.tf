terraform {
    version= ">=0.13"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.token 
}
#Ref https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens