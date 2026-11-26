terraform {
  required_providers {
    aws = {
      version = "~>6.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    region       = "us-east-1"
    bucket       = "devfolio-bharath-dev-12345"
    key          = "dev/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }

}

provider "aws" {
  region = "us-east-1"
}
