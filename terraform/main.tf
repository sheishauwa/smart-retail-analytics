# --------------------------
# S3 Bucket (Raw Zone)
# --------------------------
resource "aws_s3_bucket" "raw_zone" {
  bucket = var.raw_bucket_name

  tags = {
    Name = "SmartRetailRawZone"
  }
}

# --------------------------
# IAM Role for EC2 to Access S3
# --------------------------
resource "aws_iam_role" "ec2_role" {
  name = "EC2S3AccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "EC2S3AccessPolicy"
  role = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"],
        Resource = [
          aws_s3_bucket.raw_zone.arn,
          "${aws_s3_bucket.raw_zone.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

# --------------------------
# EC2 Instance for Ingestion
# --------------------------
resource "aws_instance" "ingestion_ec2" {
  ami                         = "ami-08c40ec9ead489470" # Amazon Linux 2
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "RetailIngestionEC2"
  }
}
