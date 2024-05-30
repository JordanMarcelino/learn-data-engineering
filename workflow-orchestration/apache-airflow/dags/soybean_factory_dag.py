from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {"owner": "jordan", "retries": 5, "retry_delay": timedelta(minutes=2)}

with DAG(
    dag_id="soy_factory_v1",
    default_args=default_args,
    description="soy factory simulation",
    start_date=datetime(2024, 4, 22, 2),
    schedule_interval="@daily",
) as dag:
    task1 = BashOperator(
        task_id="task1",
        bash_command="echo collect soy beans",
    )
    task2 = BashOperator(
        task_id="task2",
        bash_command="echo creating tempe",
    )
    task3 = BashOperator(
        task_id="task3",
        bash_command="echo creating soy bean milk",
    )
    task4 = BashOperator(
        task_id="task4",
        bash_command="distribute items",
    )

    task1 >> [task2, task3]
    [task2, task3] >> task4
