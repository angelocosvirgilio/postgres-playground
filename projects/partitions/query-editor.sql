-- drop table partitions.customers CASCADE;

--INSERT INTO partitions.customers VALUES  (6,'EXPIRED',80);


--SELECT tableoid::regclass,* FROM partitions.customers;

 --INSERT INTO partitions.furniture (product_id, category, product_name, price)
-- VALUES (11, 'Clothing', 'Tv color', 999.00);

--SELECT *, tableoid::regclass "partition_table" FROM partitions.products

--INSERT INTO partitions.sales_february (sale_id, sale_date, product_id, quantity, amount)
--VALUES (14,'2024-01-01', 199, 5, 110.00);

--ALTER TABLE partitions.products ADD COLUMN discount NUMERIC;

update partitions.products
set category='Electronics'
where product_id=2;


select * from partitions.electronics