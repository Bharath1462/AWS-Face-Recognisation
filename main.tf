provider "aws" {
  region = var.region
}

# Create S3 Bucket
resource "aws_s3_bucket" "rekognition_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Rekognition Image Bucket"
    Environment = "Dev"
  }
}

# Rekognition IAM Role
resource "aws_iam_role" "rekognition_role" {
  name = "rekognition_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "rekognition.amazonaws.com"
      }
    }]
  })
}

# Attach Policy to allow Rekognition to read from S3
resource "aws_iam_policy" "rekognition_policy" {
  name        = "RekognitionS3AccessPolicy"
  description = "Allows Rekognition to access S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${aws_s3_bucket.rekognition_bucket.arn}",
          "${aws_s3_bucket.rekognition_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rekognition_policy_attach" {
  role       = aws_iam_role.rekognition_role.name
  policy_arn = aws_iam_policy.rekognition_policy.arn
}

# Rekognition Collection
resource "aws_rekognition_collection" "face_collection" {
  collection_id = var.rekognition_collection_id
}
