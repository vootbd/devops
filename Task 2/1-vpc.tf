# configured aws provider with proper credentials
provider "aws" {
  #region    = "us-west-2"
  profile   = "default"
}


# create default vpc if one does not exit
resource "aws_default_vpc" "default_vpc" {

  tags    = {
    Name  = "default vpc"
  }
}