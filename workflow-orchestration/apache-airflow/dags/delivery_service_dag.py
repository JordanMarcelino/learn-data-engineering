from datetime import datetime, timedelta

from airflow.decorators import dag, task

default_args = {"owner": "jordan", "retries": 5, "retry_delay": timedelta(minutes=2)}


@dag(
    dag_id="delivery_service_dag_v1",
    default_args=default_args,
    description="send and receive some items",
    start_date=datetime(2024, 4, 23, 4),
    schedule_interval="@daily",
)
def delivery_service_etl():
    @task()
    def get_items():
        return ["chicken", "salmon", "sheep"]

    @task()
    def send_items(items):
        for item in items:
            print(f"sending item: {item}...")

    items = get_items()
    send_items(items)


delivery_service_etl()
