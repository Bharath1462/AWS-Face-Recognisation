Work flow of AWS-Face-Recognisation

User uploads image to S3 Bucket
            ↓
     S3 triggers Lambda
            ↓
 Lambda calls Recognition API
            ↓
 Face details printed in CloudWatch Logs

✅ Workflow Analysis
--> User Uploads Image to S3 Bucket
    This triggers an event.

--> S3 Bucket Triggers Lambda Function
    Event notification configuration is used to invoke a Lambda.

--> Lambda Calls Amazon Recognition
    Inside the Lambda function, the image is passed to Rekognition's DetectFaces API.

--> Recognition Response is Logged
    The Lambda writes the detected face details to CloudWatch Logs.  

--->Post-Terraform Manual Steps
🔹 Upload image to S3 (manually or with AWS CLI):
aws s3 cp myface.jpg s3://recognition-image-bucket-12345/
🔹 Index face via AWS CLI:
aws recognition index-faces \
  --collection-id face-collection-demo \
  --image "S3Object={Bucket=rekognition-image-bucket-12345,Name=myface.jpg}" \
  --external-image-id "person1" \
  --region us-east-1
🔹 Search for face match:
aws recognition search-faces-by-image \
  --collection-id face-collection-demo \
  --image "S3Object={Bucket=recognition-image-bucket-12345,Name=myface.jpg}" \
  --region us-east-1

✅ Requirements
AWS CLI configured (aws configure)
Terraform v1.x+
Valid AWS IAM credentials with rights to Rekognition, IAM, and S3
