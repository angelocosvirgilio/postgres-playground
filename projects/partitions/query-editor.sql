-- drop table partitions.customers CASCADE;

--INSERT INTO partitions.customers VALUES  (6,'EXPIRED',80);


--SELECT tableoid::regclass,* FROM partitions.customers;

 --INSERT INTO partitions.furniture (product_id, category, product_name, price)
-- VALUES (11, 'Clothing', 'Tv color', 999.00);

--SELECT *, tableoid::regclass "partition_table" FROM partitions.products


ALTER TABLE partitions.products ADD COLUMN discount NUMERIC;