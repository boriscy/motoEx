#!/usr/bin/env python

import pycurl
import os

url = 'http://localhost:8000/test'
file_path = os.path.realpath(__file__)

data = [
    ("username", "duh"),
    ("password", "test"),
    ("file", (pycurl.FORM_FILE, file_path)),
    ]

curl = pycurl.Curl()
curl.setopt(pycurl.POST, 1)
curl.setopt(pycurl.URL, url)
curl.setopt(pycurl.HTTPPOST, data)
#curl.setopt(pycurl.VERBOSE, 1)

curl.perform()
curl.close()


