import requests
import json
import boto3

def upload_file(file_name, bucket, text):
    file_path = 'json_api/'+file_name
    s3 = boto3.resource('s3')
    my_bucket = s3.Bucket(bucket)
    if len(list(my_bucket.objects.filter(Prefix=file_path))) == 0:
        s3.Object(bucket, file_path).put(Body=text)

def main():
    url = 'https://datausa.io/api/data?drilldowns=Nation&measures=Population'
    bucket = "yossi-rearc-test"

    response = requests.get(url).json()
    data = response['data']
    json_text = json.dumps(data)
    upload_file('us_pop.json', bucket, json_text)





if __name__ == "__main__":
    main()