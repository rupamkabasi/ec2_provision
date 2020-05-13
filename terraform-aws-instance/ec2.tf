provider "aws" {
  profile    = "default"
  region     = "ap-southeast-2"
}

resource "aws_instance" "EC2" {
  ami           = "ami-0810abbfb78d37cdf"
  instance_type = "t2.micro"
}