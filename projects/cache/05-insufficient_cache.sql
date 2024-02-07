SELECT pg_stat_reset();

SELECT count(*) from cache.tbldummy where c_id < 150;

SELECT heap_blks_read, heap_blks_hit from pg_statio_user_tables where relname='tbldummy';