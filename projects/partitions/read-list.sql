-- Retrieve electronics partitions.products
SELECT *, tableoid::regclass "partition_table" FROM partitions.products WHERE category = 'Electronics';

-- Retrieve clothing partitions.products
SELECT *, tableoid::regclass "partition_table" FROM partitions.products WHERE category = 'Clothing';

-- Retrieve furniture partitions.products
SELECT *, tableoid::regclass "partition_table" FROM partitions.products WHERE category = 'Furniture';