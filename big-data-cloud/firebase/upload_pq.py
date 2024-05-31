import firebase_admin
import pandas as pd
from firebase_admin import credentials, storage

creds = credentials.Certificate(
    r"D:\Users\Jordan\VS-CODE\learn\ml\learn-data-engineering\big-data-cloud\firebase\accountKey.json"
)

firebase_admin.initialize_app(
    credential=creds, options={"storageBucket": "explore-de-36dfa.appspot.com"}
)

bucket = storage.bucket()

blob = bucket.blob(blob_name="diabetes.parquet")

df = pd.read_csv("diabetes.csv")
df.to_parquet("diabetes.parquet")

blob.upload_from_filename("diabetes.parquet")
