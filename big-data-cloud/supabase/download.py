import os

import pandas as pd
from dotenv import load_dotenv
from supabase import Client, create_client

load_dotenv()

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_KEY")
supabase: Client = create_client(url, key)

with open("test.csv", "wb") as f:
    res = supabase.storage.get_bucket("explore-de").download("diabetes.csv")
    f.write(res)

df = pd.read_csv("test.csv")
print(df.head())
