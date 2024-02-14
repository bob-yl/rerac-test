#resource "aws_lambda_function" "rerac_part_one" {
#    filename = "../part_1.py"
#    function_name = "rerac-part-1"
#    role = aws_iam_role.terraform_function_role.arn
#    handler = "index.handler"
#}
#
#resource "aws_cloudwatch_event_rule" "every_day" {
#    name = "every-day"
#    description = "Fires every day"
#    schedule_expression = "cron(0 0 * * *)"
#}
#
#resource "aws_cloudwatch_event_target" "rerac_run_part_1_every_day" {
#    rule = aws_cloudwatch_event_rule.every_five_minutes.name
#    target_id = "check_foo"
#    arn = aws_lambda_function.check_foo.arn
#}
#
#resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
#    statement_id = "AllowExecutionFromCloudWatch"
#    action = "lambda:InvokeFunction"
#    function_name = aws_lambda_function.check_foo.function_name
#    principal = "events.amazonaws.com"
#    source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
#}