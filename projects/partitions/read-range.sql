-- Retrieve sales data for January
SELECT *, tableoid::regclass "partition_table" FROM partitions.sales WHERE sale_date >= '2024-01-01' AND sale_date < '2024-02-01';

-- Retrieve sales data for February
SELECT *, tableoid::regclass "partition_table" FROM partitions.sales WHERE sale_date >= '2024-02-01' AND sale_date < '2024-03-01';

-- Retrieve sales data for March
SELECT *, tableoid::regclass "partition_table" FROM partitions.sales WHERE sale_date >= '2024-03-01' AND sale_date < '2024-04-01';