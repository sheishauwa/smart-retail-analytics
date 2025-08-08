provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "raw_zone" {
  bucket = "smart-retail-raw-zone"
}

resource "aws_instance" "ingestion_ec2" {
  ami           = "ami-08c40ec9ead489470" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  tags = {
    Name = "RetailIngestionEC2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.ingestion_ec2.public_ip
}

