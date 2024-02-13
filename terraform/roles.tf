#data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
#  statement {
#    actions    = ["sts:AssumeRole"]
#    effect     = "Allow"
#    principals {
#      type        = "Service"
#      identifiers = ["lambda.amazonaws.com"]
#    }
#  }
#}
#
#resource "aws_iam_role" "terraform_function_role" {
#  name               = "terraform_function_role"
#  assume_role_policy = "${data.aws_iam_policy_document.AWSLambdaTrustPolicy.json}"