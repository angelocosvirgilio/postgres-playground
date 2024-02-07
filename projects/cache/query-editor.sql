--SELECT count(*) from cache.tbldummy;

--SELECT * FROM pg_settings WHERE name = 'shared_buffers'

--select * from pg_stat_activity where state='active'

select heap_blks_read, heap_blks_hit from pg_statio_user_tables where relname='tbldummy'