SELECT pg_stat_reset();
EXPLAIN ANALYZE SELECT count(*) from cache.tbldummy where c_id=1;
