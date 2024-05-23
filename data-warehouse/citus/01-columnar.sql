-- Create table 
CREATE TABLE IF NOT EXISTS products(
    id SERIAL PRIMARY KEY,
    name TEXT,
    description TEXT,
    price NUMERIC(10, 2),
    category TEXT,
    manufacturer TEXT
) USING columnar;
-- Insert 100k data
INSERT INTO products(
        id,
        name,
        description,
        price,
        category,
        manufacturer
    )
SELECT GENERATE_SERIES,
    'Product ' || GENERATE_SERIES,
    'Description ' || GENERATE_SERIES,
    (RANDOM() * 1000)::NUMERIC(10, 2),
    'Category ' || (GENERATE_SERIES % 5 + 1),
    'Manufacturer ' || (GENERATE_SERIES % 3 + 1)
FROM GENERATE_SERIES(1, 100000);
-- Query data
SELECT category,
    AVG(price) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price;