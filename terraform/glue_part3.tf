resource "aws_s3_object" "glue_script" {
  bucket = "yossi-rearc-test"
  key    = "scripts/pyspark_script.py"
  source = "bin/part_3/pyspark_script.py"
}

resource "aws_glue_job" "report_generation" {
  name              = "rerac-part3"
  role_arn          = aws_iam_role.glue_role.arn
  glue_version      = "3.0"
  number_of_workers = 2
  worker_type       = "G.1X"
  max_retries       = "1"
  timeout           = 2880
  command {
    name            = "glueetl"
    script_location = "s3://yossi-rearc-test/${aws_s3_object.glue_script.key}"
  }
  default_arguments = {
    "--enable-auto-scaling"              = "false"
    "--enable-continuous-cloudwatch-log" = "true"
  }
}