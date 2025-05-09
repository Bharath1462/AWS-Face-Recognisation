output "s3_bucket_name" {
  value = aws_s3_bucket.rekognition_bucket.bucket
}

output "rekognition_collection_id" {
  value = aws_rekognition_collection.face_collection.collection_id
}
