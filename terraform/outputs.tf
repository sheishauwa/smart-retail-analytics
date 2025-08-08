output "s3_bucket_name" {
  description = "Name of the S3 bucket for raw data"
  value       = aws_s3_bucket.raw_zone.bucket
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ingestion_ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.ingestion_ec2.public_dns
}

