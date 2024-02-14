data "aws_iam_policy_document" "s3_access_doc" {
  statement {
    sid = "1"
    actions = ["s3:*",]
    resources = [
      "arn:aws:s3:::yossi-rearc-test",
      "arn:aws:s3:::yossi-rearc-test/*",
    ]
  }
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "rearc-s3-policy"
  path        = "/"
  description = "Allow s3 access to bucket"

  policy = "${data.aws_iam_policy_document.s3_access_doc.json}"
}

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "rerac-lambda-role"
  assume_role_policy = "${data.aws_iam_policy_document.AWSLambdaTrustPolicy.json}"
}

resource "aws_iam_role_policy_attachment" "s3_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}