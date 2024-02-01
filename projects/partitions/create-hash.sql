CREATE TABLE partitions.orders (
    order_id INT,
    order_date DATE,
    customer_id INT,
    total_amount NUMERIC
) partition by hash(customer_id);


-- We’ll create individual tables to represent each partition, with each partition covering a specific range of hash values.
-- we use the HASH() function to specify that the data should be partitioned based on the hash value of the customer_id column. 
-- We use MODULUS and REMAINDER to specify the number of partitions (3 in this case) and the remainder value for each partition.

CREATE TABLE partitions.orders_1 PARTITION OF partitions.orders
    FOR VALUES WITH (MODULUS 3, REMAINDER 0);

CREATE TABLE partitions.orders_2 PARTITION OF partitions.orders
    FOR VALUES WITH (MODULUS 3, REMAINDER 1);

CREATE TABLE partitions.orders_3 PARTITION OF partitions.orders
    FOR VALUES WITH (MODULUS 3, REMAINDER 2);


-- NB HASH() function is: (hashint4extended(customer_id, 8816678312871386365)::numeric + 5305509591434766563)
