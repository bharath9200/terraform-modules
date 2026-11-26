    variable "vpc_cidr" {
        type = string
    }

    variable "project" {
        type = string
    }

    variable "env" {
        type = string
    }

    variable "vpc_tags" {
        type = map
        default = {}
    }

    variable "igw_tags" {
        type = map
        default = {}
    }

    variable "public_subnet_cidr" {
        type = list(string)

    }

    variable "private_subnet_cidr" {
        type = list(string)
    }

     variable "subnet_tags" {
        type = map
        default = {}
    }


    variable "natgw_tags" {
        type = map
        default = {}
    }

    variable "natgw_name" {
        type = string
    }

    variable "eip_tags" {
        type = map
        default = {}
    }