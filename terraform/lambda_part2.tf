
data "archive_file" "rerac_part2_archive" {
  type        = "zip"
  source_dir = "bin/part_2"
  output_path = "part2.zip"
}
resource "aws_lambda_function" "part2_lambda" {
  filename      = "part2.zip"
  function_name = "rerac-part-2"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  timeout       = 900
  layers        = ["${aws_lambda_layer_version.bs4.arn}", "${aws_lambda_layer_version.requests.arn}"]
}
resource "aws_cloudwatch_event_target" "part2_trigger_event" {
  rule = aws_cloudwatch_event_rule.every_day.name
  arn = aws_lambda_function.part2_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_part_2" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.part2_lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.every_day.arn
}