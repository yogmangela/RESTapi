provider "aws" {
  access_key =  //"add your access_key"
  secret_key =  //"add your secret_key"
  region     =  //"add your region"
  version    = "~> 2.0"
}


module "apigateway" {
    source = "git::https://github.com/yogmangela/terra-modules//apigateway"
}


module "dynamodb" {
    source = "git::https://github.com/yogmangela/terra-modules//dynamodb"
}

