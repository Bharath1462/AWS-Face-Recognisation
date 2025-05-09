provider "aws" {
  region = var.region
}

# Create S3 Bucket
resource "aws_s3_bucket" "recognition_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Recognition Image Bucket"
    Environment = "Dev"
  }
}

# Recognition IAM Role
resource "aws_iam_role" "recognition_role" {
  name = "recognition_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "recognition.amazonaws.com"
      }
    }]
  })
}

# Attach Policy to allow Recognition to read from S3
resource "aws_iam_policy" "recognition_policy" {
  name        = "RecognitionS3AccessPolicy"
  description = "Allows Recognition to access S3 bucket"
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
          "${aws_s3_bucket.recognition_bucket.arn}",
          "${aws_s3_bucket.recognition_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "recognition_policy_attach" {
  role       = aws_iam_role.recognition_role.name
  policy_arn = aws_iam_policy.recognition_policy.arn
}

# Recognition Collection
resource "aws_recognition_collection" "face_collection" {
  collection_id = var.recognition_collection_id
}
