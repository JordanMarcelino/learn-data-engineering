import firebase_admin
from firebase_admin import credentials, storage

creds = credentials.Certificate(
    r"D:\Users\Jordan\VS-CODE\learn\ml\learn-data-engineering\big-data-cloud\firebase\accountKey.json"
)

firebase_admin.initialize_app(
    credential=creds, options={"storageBucket": "explore-de-36dfa.appspot.com"}
)

bucket = storage.bucket()

blob = bucket.get_blob("diabetes.csv")

blob.download_to_filename("diabetes.csv")
