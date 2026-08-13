terraform {
  required_version = ">= 1.9.0"

  cloud {
    # hostname에는 https://를 붙이지 않음
    hostname     = "ec2-3-35-137-82.ap-northeast-2.compute.amazonaws.com"
    organization = "cw-tfe-test"

    workspaces {
      name = "cw-tfe-test"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
