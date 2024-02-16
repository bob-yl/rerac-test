## Part 1
* s3 bucket [link](https://s3.us-east-1.amazonaws.com/yossi-rearc-test/api_rest/)
* Used file names to decide which file to migrate but, I can also use modified date to load only changed files (MD5 is also an option but, I tried it in the past and it never worked)

## Part 2
* Removed file check condition from s3 file upload to make sure updated data will overwrite the existing one

## Part 3
* TODO: Clean up code and set naming conventions for DF's


## Part 4
* Keep running into `cannot import name 'DEFAULT_CIPHERS' from 'urllib3.util.ssl_'` error. I just solved it!!!!! (` pip install --target terraform/packages/requests/python/ requests "urllib3<2" --upgrade`)
* TODO: move to modules on terraform
* Loading pySpark as a lambda function requires containers, so, I chose to run the 3rd part as Glue job for time saving purposes


If I had more time, I would add some error handling in the lambda functions