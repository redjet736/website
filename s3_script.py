import time
import hmac
import hashlib
import base64

access_id = "AKIAI6R7I2B3XTKMB76A"
access_secret = "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"

test_id = "AKIAIOSFODNN7EXAMPLE"
test_secret = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

def now():
    return time.strftime("%a, %d %b %Y %H:%M:%S +0000", time.gmtime())

def string_to_sign(time, formatted_path, verb = 'get'):
    x = verb.upper();
    x += "\n\n\n"
    x += time + "\n"
    x += formatted_path
    return x

def auth(key, sig):
    return "AWS " + str(key) + ":" + sig

def sign(key, s):
    h = hmac.new(key, s.encode('utf8'), hashlib.sha1).digest()
    return base64.encodestring(h)[:-1] # remove \n at end of string

def generate_test_curl():
    time = "Tue, 27 Mar 2007 19:36:42 +0000"
    path = "/photos/puppy.jpg"
    host = "johnsmith.s3.amazonaws.com"
    formatted_path = "/johnsmith/photos/puppy.jpg"

    s = string_to_sign(time, formatted_path)
    signed = sign(test_secret, s)
    auth_header = auth(test_id, signed)

    query = "curl -H \"Authorization: " + auth_header + "\" "
    query += "-H \"Date: " + time + "\" "
    query += host + path + " -v"

    return query

def generate_resume_curl():
    time = now()
    path = "/updated_resume.pdf"
    # host = "andys-website-assets.s3.amazonaws.com"
    host = "http://andys-website-assets.s3.amazonaws.com"
    formatted_path = "/andys-website-assets/updated_resume.pdf"

    s = string_to_sign(time, formatted_path)
    signed = sign(access_secret, s)
    auth_header = auth(access_id, signed)

    query = "curl -H \"Authorization: " + auth_header + "\" "
    query += "-H \"Date: " + time + "\" "
    query += host + path + " -v"

    return query


