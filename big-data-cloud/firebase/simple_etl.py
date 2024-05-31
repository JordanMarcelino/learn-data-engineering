import firebase_admin
import numpy as np
import pandas as pd
from firebase_admin import credentials, storage


def extract(filename: str) -> pd.DataFrame:
    df = pd.read_csv(filename)

    return df


def transform(df: pd.DataFrame) -> pd.DataFrame:
    df = df.drop_duplicates()
    df = df.replace(0, np.nan)

    nullable = df.isna().sum() > 0
    columns = nullable.index[nullable.values]

    for col in columns:
        df[col] = df[col].fillna(df[col].mean())

    df = df.reset_index()

    return df


def load(df: pd.DataFrame) -> None:
    creds = credentials.Certificate(
        r"D:\Users\Jordan\VS-CODE\learn\ml\learn-data-engineering\big-data-cloud\firebase\accountKey.json"
    )

    firebase_admin.initialize_app(
        credential=creds, options={"storageBucket": "explore-de-36dfa.appspot.com"}
    )

    bucket = storage.bucket()

    filename = "test.parquet"

    df.to_parquet(filename)

    blob = bucket.blob(blob_name="test.parquet")

    blob.upload_from_filename(filename="test.parquet")


df = extract("diabetes.csv")
df_transformed = transform(df)

load(df_transformed)
