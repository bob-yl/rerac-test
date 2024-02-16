resource "aws_s3_bucket_notification" "part3_notifications" {
  bucket = "yossi-rearc-test"

  queue {
    queue_arn     = "${aws_sqs_queue.rerac_part3_queue.arn}"
    events        = ["s3:ObjectCreated:*"]
  }
}