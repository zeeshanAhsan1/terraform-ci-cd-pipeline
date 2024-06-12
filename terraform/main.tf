terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>4.0"
      }
    }

    #backend -> means where terraform state file will be stored
    backend "s3" {
      key = "aws/ec2-deploy/terraform.tfstate"
    }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "name" {
    ami = "ami-0f30a9c3a48f3fa79"
    instance_type = "t2.micro"
    #Attach aws_key_pair to this instance
    key_name = aws_key_pair.deployer.key_name
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = var.private_key
        timeout = "4m"
    }
    tags = {
        "name" = "DeployVM"
    }
}

resource "aws_key_pair" "deployer"{
    key_name = var.key_name
    public_key = var.public_key

}

