-- Create table transactions
CREATE TABLE transactions(
    date TIMESTAMPTZ,
    id INT,
    amount NUMERIC(10, 2),
    customer_id INT
) PARTITION BY RANGE(date);
-- Create table partition for each month
-- Jan
CREATE TABLE transactions_jan24 PARTITION OF transactions FOR
VALUES
FROM ('2024-01-01') TO ('2024-02-01') USING columnar;
-- Feb
CREATE TABLE transactions_feb24 PARTITION OF transactions FOR
VALUES
FROM ('2024-02-01') TO ('2024-03-01') USING columnar;
-- Mar
CREATE TABLE transactions_mar24 PARTITION OF transactions FOR
VALUES
FROM ('2024-03-01') TO ('2024-04-01');
-- Insert 1m data for each month
-- Jan
WITH random_transactions AS (
    SELECT '2024-01-01'::TIMESTAMPTZ + '10 seconds'::INTERVAL * g AS date,
        GENERATE_SERIES(1, 1000) AS id,
        (RANDOM() * 10)::NUMERIC(10, 2) AS amount,
        (RANDOM() * 1000)::INT AS customer_id
    FROM GENERATE_SERIES(1, 1000) g
)
INSERT INTO transactions(
        date,
        id,
        amount,
        customer_id
    )
SELECT date,
    id,
    amount,
    customer_id
FROM random_transactions;
-- Feb
WITH random_transactions AS (
    SELECT '2024-02-01'::TIMESTAMPTZ + '10 seconds'::INTERVAL * g AS date,
        GENERATE_SERIES(1, 1000) AS id,
        (RANDOM() * 10)::NUMERIC(10, 2) AS amount,
        (RANDOM() * 1000)::INT AS customer_id
    FROM GENERATE_SERIES(1, 1000) g
)
INSERT INTO transactions(
        date,
        id,
        amount,
        customer_id
    )
SELECT date,
    id,
    amount,
    customer_id
FROM random_transactions;
-- Mar
WITH random_transactions AS (
    SELECT '2024-03-01'::TIMESTAMPTZ + '10 seconds'::INTERVAL * g AS date,
        GENERATE_SERIES(1, 1000) AS id,
        (RANDOM() * 10)::NUMERIC(10, 2) AS amount,
        (RANDOM() * 1000)::INT AS customer_id
    FROM GENERATE_SERIES(1, 1000) g
)
INSERT INTO transactions(
        date,
        id,
        amount,
        customer_id
    )
SELECT date,
    id,
    amount,
    customer_id
FROM random_transactions;
-- Alter table to columnar
SELECT ALTER_TABLE_SET_ACCESS_METHOD('transactions_mar24', 'columnar');