SET citus.enable_schema_based_sharding TO ON;
CREATE SCHEMA tenant1;
CREATE SCHEMA tenant2;
SET SEARCH_PATH TO tenant1;
CREATE TABLE product_categories(
    category_id BIGSERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);
CREATE TABLE products(
    product_id BIGSERIAL PRIMARY KEY,
    category_id BIGINT REFERENCES product_categories(category_id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2),
    quantity INT NOT NULL
);
SET SEARCH_PATH TO tenant2;
CREATE TABLE product_categories(
    category_id BIGSERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);
CREATE TABLE products(
    product_id BIGSERIAL PRIMARY KEY,
    category_id BIGINT REFERENCES product_categories(category_id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2),
    quantity INT NOT NULL
);