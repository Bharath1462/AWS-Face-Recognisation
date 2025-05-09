output "s3_bucket_name" {
  value = aws_s3_bucket.recognition_bucket.bucket
}

output "recognition_collection_id" {
  value = aws_recognition_collection.face_collection.collection_id
}
