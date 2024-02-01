CREATE TABLE partitions.products (
    product_id INT,
    category TEXT,
    product_name TEXT,
    price NUMERIC
) partition by list(category);


--We’ll create individual tables to represent each partition, with each partition covering a specific category of products
CREATE TABLE partitions.electronics PARTITION OF partitions.products
    FOR VALUES IN ('Electronics');

CREATE TABLE partitions.clothing PARTITION OF partitions.products
    FOR VALUES IN ('Clothing');

CREATE TABLE partitions.furniture PARTITION OF partitions.products
    FOR VALUES IN ('Furniture');


--Since list partitioning is based on specific values, we don’t need CHECK constraints. However, we need to set up the partitions correctly by adding rows to the appropriate tables.