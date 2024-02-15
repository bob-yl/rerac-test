resource "aws_s3_object" "glue_script" {
  bucket = "yossi-rearc-test"
  key    = "scripts/pyspark_script.py"
  source = "part3/pyspark_script.py"
}

#resource "aws_glue_job" "blogpost_job" {
#  name              = "${var.prefix}-blogpost-job-${var.env}"
#  role_arn          = aws_iam_role.glue_service_role.arn
#  glue_version      = "3.0"
#  number_of_workers = 2
#  worker_type       = "G.1X"
#  max_retries       = "1"
#  timeout           = 2880
#  command {
#    name            = "glueetl"
#    script_location = aws_s3_bucket_object.glue_script.
#  }
#  default_arguments = {
#    "--enable-auto-scaling"              = "true"
#    "--enable-continuous-cloudwatch-log" = "true"
#  }
#}