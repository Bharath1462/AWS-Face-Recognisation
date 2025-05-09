variable "region" {
  default = "eu-west-2"
}

variable "s3_bucket_name" {
  default = "aws-face-recognisation" # use a globally unique name
}

variable "recognition_collection_id" {
  default = "face-collection-demo"
}
