variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "key_pair_name" {
  description = "AWS EC2 key pair name for SSH access"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "raw_bucket_name" {
  description = "Name of the S3 bucket for raw data storage"
  type        = string
  default     = "smart-retail-raw-zone"
}

