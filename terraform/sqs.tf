resource "aws_sqs_queue" "rerac_part3_queue" {
  name                       = "rerac-part3-queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 900
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled    = true
}

data "aws_iam_policy_document" "sqs_create_messages_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.rerac_part3_queue.arn]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values    = ["997597983503"]
    }
    condition {
      test     = "ArnLike"
      values   = ["arn:aws:s3:*:*:yossi-rearc-test"]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.rerac_part3_queue.id
  policy    = data.aws_iam_policy_document.sqs_create_messages_policy.json
}
