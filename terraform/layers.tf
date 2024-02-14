resource "aws_lambda_layer_version" "bs4" {
  filename   = "packages/bs4.zip"
  layer_name = "bs4"

  compatible_runtimes = ["python3.9"]
}

resource "aws_lambda_layer_version" "requests" {
  filename   = "packages/requests.zip"
  layer_name = "requests"

  compatible_runtimes = ["python3.9"]
}

