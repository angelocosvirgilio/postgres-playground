-- Retrieve partitions.orders for customer_id 101
SELECT *, tableoid::regclass "partition_table" FROM partitions.orders WHERE customer_id = 101;

-- Retrieve partitions.orders for customer_id 102
SELECT *, tableoid::regclass "partition_table" FROM partitions.orders WHERE customer_id = 102;

-- Retrieve partitions.orders for customer_id 103
SELECT *, tableoid::regclass "partition_table" FROM partitions.orders WHERE customer_id = 103;

-- Retrieve partitions.orders for customer_id 105
SELECT *, tableoid::regclass "partition_table" FROM partitions.orders WHERE customer_id = 105;

-- Retrieve partitions.orders for customer_id 107
SELECT *, tableoid::regclass "partition_table" FROM partitions.orders WHERE customer_id = 107;

-- Retrieve partitions.orders for customer_id 110
SELECT *, tableoid::regclass "partition_table" FROM partitions.orders WHERE customer_id = 110;