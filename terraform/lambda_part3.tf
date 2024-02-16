
data "archive_file" "rerac_part3_archive" {
  type        = "zip"
  source_file = "bin/part_3/lambda_function.py"
  output_path = "part3.zip"
}
resource "aws_lambda_function" "part3_lambda" {
  filename      = "part3.zip"
  function_name = "rerac-part-3"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  timeout       = 900
}

resource "aws_lambda_event_source_mapping" "part3_trigger" {
  event_source_arn = aws_sqs_queue.rerac_part3_queue.arn
  function_name    = aws_lambda_function.part3_lambda.arn
}