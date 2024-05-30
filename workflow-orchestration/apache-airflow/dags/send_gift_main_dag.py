from datetime import datetime, timedelta

from airflow import DAG
from airflow.models.taskinstance import TaskInstance
from airflow.operators.python import PythonOperator

default_args = {"owner": "jordan", "retries": 5, "retry_delay": timedelta(minutes=2)}


def send_gift(ti: TaskInstance):
    ti.xcom_push(key="gift", value="Air Jordan 3")


def send_mail(ti: TaskInstance):
    ti.xcom_push(key="mail", value="Hello, are you interested?")


def receive_items(ti: TaskInstance):
    gift = ti.xcom_pull(task_ids="send_gift", key="gift")
    mail = ti.xcom_pull(task_ids="send_mail", key="mail")

    print(f"received gift: {gift}")
    print(f"received mail: {mail}")


with DAG(
    dag_id="simple_gift_mail_dag_v1",
    default_args=default_args,
    description="send and receive some gifts",
    start_date=datetime(2024, 4, 23, 4),
    schedule_interval="@daily",
) as dag:
    task1 = PythonOperator(task_id="send_gift", python_callable=send_gift)
    task2 = PythonOperator(task_id="send_mail", python_callable=send_mail)
    task3 = PythonOperator(task_id="receive_items", python_callable=receive_items)

    [task1, task2] >> task3
