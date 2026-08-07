terraform {
  cloud {
    organization = "Cloudnetworks-PlatformTeam"
    hostname = "app.terraform.io"
    workspaces {
      name = cwlee_test
    }
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}