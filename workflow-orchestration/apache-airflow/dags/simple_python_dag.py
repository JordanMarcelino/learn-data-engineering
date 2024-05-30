from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python import PythonOperator

default_args = {"owner": "jordan", "retries": 5, "retry_delay": timedelta(minutes=2)}


def add_numbers(number1: int, number2: int) -> str:
    result = number1 + number2

    return f"{number1} + {number2} = {result}"


with DAG(
    dag_id="simple_python_v1",
    default_args=default_args,
    description="simple python flow",
    start_date=datetime(2024, 4, 23, 4),
    schedule_interval="@daily",
) as dag:
    task = PythonOperator(
        task_id="add_task",
        python_callable=add_numbers,
        op_kwargs={"number1": 1, "number2": 5},
    )
