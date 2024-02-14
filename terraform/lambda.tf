resource "aws_cloudwatch_event_rule" "every_day" {
  name = "every-day"
  description = "Fires every day"
  schedule_expression = "cron(0 0 * * ? *)"
}
data "archive_file" "rerac_part1_archive" {
  type        = "zip"
  source_file = "bin/part_1/lambda_function.py"
  output_path = "part1.zip"
}
resource "aws_lambda_function" "part1_lambda" {
  filename      = "part1.zip"
  function_name = "rerac-part-1"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  timeout       = 10
  layers        = ["arn:aws:lambda:us-east-1:997597983503:layer:bs4:1"]
}
resource "aws_cloudwatch_event_target" "part1_trigger_event" {
  rule = aws_cloudwatch_event_rule.every_day.name
  arn = aws_lambda_function.part1_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_part_1" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.part1_lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.every_day.arn
}