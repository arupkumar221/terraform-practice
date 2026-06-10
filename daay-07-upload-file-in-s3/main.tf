# IAM Role for Lambda

resource "aws_iam_role" "lambda_role" {
  name = "lambda_arup_role_v2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Lambda Basic Execution Policy

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# S3 Bucket

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "arup-lambda-code-bucket-12345"
}

# Upload ZIP file to S3

resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip"

  etag = filemd5("lambda_function.zip")
}

# Lambda Function

resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function_v2"

  role    = aws_iam_role.lambda_role.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.12"

  timeout     = 900
  memory_size = 128

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_zip.key

  source_code_hash = filebase64sha256("lambda_function.zip")

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy,
    aws_s3_object.lambda_zip
  ]
