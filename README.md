## Part 1
* s3 bucket [link](https://s3.us-east-1.amazonaws.com/yossi-rearc-test/api_rest/)

## Part 2
* TODO: Might need to add overwrite to `upload_file` function for s3 notification

## Part 3
* TODO: Clean up code and set naming conventions for DF's

## Part 4
* TODO: Save files to S3
* keep running into `cannot import name 'DEFAULT_CIPHERS' from 'urllib3.util.ssl_'` error, I just solved it!!!!! (` pip install --target terraform/packages/requests/python/ requests "urllib3<2" --upgrade`)
*