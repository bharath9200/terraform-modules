locals {
    env_name = "${var.project}-${var.env}"
    tags = {
        Project = var.project
        Enviornment = var.env
    }

    azs = slice(data.aws_availability_zones.available.names, 0, 2)

    public_subnet_map = {
        for i, cidr in var.public_subnet_cidr : cidr => local.azs[i]
    }


  #  public_subnet_cidr = ["10.110.1.0/24", "10.110.2.0/24"]
  #  azs   = ["us-east-1a", "us-east-1b"]

  # Loop runs twice (i = 0, then i = 1) to build this map:
  # {
  #   "10.110.1.0/24" = "us-east-1a"
  #   "10.110.2.0/24" = "us-east-1b"
  # }

    private_subnet_map = {
        for i, cidr in var.private_subnet_cidr : cidr => local.azs[i]
    }
}
