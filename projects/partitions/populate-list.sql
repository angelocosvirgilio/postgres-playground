-- we can insert data into the partitions.products table, and PostgreSQL will automatically route the data to the appropriate partition based on the category.
INSERT INTO partitions.products (product_id, category, product_name, price)
VALUES (1, 'Electronics', 'Smartphone', 500.00);

INSERT INTO partitions.products (product_id, category, product_name, price)
VALUES (2, 'Clothing', 'T-Shirt', 25.00);

INSERT INTO partitions.products (product_id, category, product_name, price)
VALUES (3, 'Furniture', 'Sofa', 800.00);

INSERT INTO partitions.products (product_id, category, product_name, price)
VALUES (4, 'Electronics', 'Laptop', 1500.00);

INSERT INTO partitions.products (product_id, category, product_name, price)
VALUES (5, 'Clothing', 'Jeans', 50.00);

INSERT INTO partitions.products (product_id, category, product_name, price)
VALUES (6, 'Clothing', 'Shoes', 100.00);
