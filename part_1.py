import requests
import boto3
import os
import re
from bs4 import BeautifulSoup


def upload_file(file_name, bucket, text):
    file_path = 'api_rest/'+file_name
    s3 = boto3.resource('s3')
    my_bucket = s3.Bucket(bucket)
    if len(list(my_bucket.objects.filter(Prefix=file_path))) == 0:
        s3.Object(bucket, file_path).put(Body=text)

def main():
    headers = {'Content-type': 'application/json', 'From': 'joe.levi.email@gmail.com', 'Connection': 'keep-alive',
               'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) '
                             'Chrome/121.0.0.0 Safari/537.36'}
    bucket = "yossi-rearc-test"


    url = 'https://download.bls.gov/pub/time.series/pr/'
    text = requests.get(url, headers=headers).text

    temp_url = 'https://download.bls.gov/pub/time.series/pr/pr.contacts'
    x = requests.get(temp_url, headers=headers).text


    files = BeautifulSoup(text, 'html.parser')

    p = ".*pr"
    for file in files.find_all('a'):
        if re.match(p, str(file)) :
            file_name = os.path.split(file['href'])[-1]
            file_url = url+file_name
            x = requests.get(file_url, headers=headers).text
            upload_file(file_name, bucket, x)

if __name__ == "__main__":
    main()