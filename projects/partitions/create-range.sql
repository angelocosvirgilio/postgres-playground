/** 
        Range "partitions"
*/
CREATE TABLE "partitions".sales (
    sale_id INT,
    sale_date DATE,
    product_id INT,
    quantity INT,
    amount NUMERIC
) partition by range (sale_date);

-- We’ll create individual tables to represent each partition, each covering a specific range of dates.
CREATE TABLE "partitions".sales_january PARTITION OF "partitions".sales
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE "partitions".sales_february PARTITION OF "partitions".sales
    FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

CREATE TABLE "partitions".sales_march PARTITION OF "partitions".sales
    FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');

-- We need to define constraints on each partition to ensure that data is correctly routed to the appropriate partition.
ALTER TABLE "partitions".sales_january ADD CONSTRAINT sales_january_check
    CHECK (sale_date >= '2024-01-01' AND sale_date < '2024-02-01');

ALTER TABLE "partitions".sales_february ADD CONSTRAINT sales_february_check
    CHECK (sale_date >= '2024-02-01' AND sale_date < '2024-03-01');

ALTER TABLE "partitions".sales_march ADD CONSTRAINT sales_march_check
    CHECK (sale_date >= '2024-03-01' AND sale_date < '2024-04-01');