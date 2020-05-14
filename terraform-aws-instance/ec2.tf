provider "aws" {
  profile    = "default"
  region     = "ap-southeast-2"
}

data "aws_ami" "latest-Rhel" {
most_recent = true
owners = ["309956199498"]

    filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

resource "aws_security_group" "sg" {
  name        = "terraform-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-32d1d255"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["220.233.72.231/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-sg"
  }
}

resource "aws_instance" "EC2" {
  ami           = "${data.aws_ami.latest-Rhel.id}"
  instance_type = "t2.micro"
  tags = {
      Name = "terraform-build"
  }

}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.sg.id}"
  network_interface_id = "${aws_instance.EC2.primary_network_interface_id}"
}