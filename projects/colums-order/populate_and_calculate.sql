-- add 1 million rows
INSERT INTO columns_order.t_broad
       SELECT 'a' FROM generate_series(1, 1000000);

-- size
SELECT pg_size_pretty(pg_total_relation_size('columns_order.t_broad'));