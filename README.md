Work flow of AWS-Face-Recognisation

# User uploads image to S3 Bucket
            ↓
#     S3 triggers Lambda
            ↓
# Lambda calls Recognition API
            ↓
# Face details printed in CloudWatch Logs

✅ Workflow Analysis
# User Uploads Image to S3 Bucket
  This triggers an event.

# S3 Bucket Triggers Lambda Function
  Event notification configuration is used to invoke a Lambda.

# Lambda Calls Amazon Recognition
  Inside the Lambda function, the image is passed to Rekognition's DetectFaces API.

# Recognition Response is Logged
  The Lambda writes the detected face details to CloudWatch Logs.  
