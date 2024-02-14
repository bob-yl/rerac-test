## Part 1
* s3 bucket [link](https://s3.us-east-1.amazonaws.com/yossi-rearc-test/api_rest/)
* used file names to decide which file to migrate but, I can also use modified date to load only changed files (MD5 is also an option but, I tried it in the past and it never worked)

## Part 2
* TODO: Might need to add overwrite to `upload_file` function for s3 notification

## Part 3
* TODO: Clean up code and set naming conventions for DF's

## Part 4
* TODO: Save files to S3
* Keep running into `cannot import name 'DEFAULT_CIPHERS' from 'urllib3.util.ssl_'` error, I just solved it!!!!! (` pip install --target terraform/packages/requests/python/ requests "urllib3<2" --upgrade`)
* Would have loved building some modules here
* 