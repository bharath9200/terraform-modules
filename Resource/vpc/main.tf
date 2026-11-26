# resource "aws_s3_bucket" "backend" {
#   bucket = "devfolio-bharath-dev-12345"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }


module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = "10.110.0.0/16"
  project             = "Devfolio"
  env                 = "dev"
 public_subnet_cidr  = [ "10.110.1.0/24" , "10.110.2.0/24" ]
 private_subnet_cidr = [ "10.110.11.0/24" , "10.110.12.0/24" ]
  natgw_name          = "bharath_ngw"

  vpc_tags = {
    Name = "Devolio_vpc"
  }

}