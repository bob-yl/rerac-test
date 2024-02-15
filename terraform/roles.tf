# Lambda Role

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

data "aws_iam_policy_document" "rerac-lambda-trust-policy" {
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
  assume_role_policy = "${data.aws_iam_policy_document.rerac-lambda-trust-policy.json}"
}

resource "aws_iam_role_policy_attachment" "s3_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Glue Role

data "aws_iam_policy_document" "logging_access_doc" {
  statement {
    sid = "1"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:*:*:*:/aws-glue/*",
      "arn:aws:logs:*:*:*:/customlogs/*",
    ]
  }
}

resource "aws_iam_policy" "logging_access_role" {
  name        = "rearc-logging-policy"
  path        = "/"
  description = "Allow logging to cloudwatch"

  policy = "${data.aws_iam_policy_document.logging_access_doc.json}"
}

data "aws_iam_policy_document" "rerac-glue-trust-policy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "glue_role" {
  name               = "rerac-glue-role"
  assume_role_policy = "${data.aws_iam_policy_document.rerac-glue-trust-policy.json}"
}

resource "aws_iam_role_policy_attachment" "s3_glue_role_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "logging_glue_role_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.logging_access_role.arn
}