
SELECT * FROM "skip-locked".job_queue;

SELECT 
	t.schemaname,
    t.relname AS table_name, 
    l.locktype, 
    l.page, 
    l.virtualtransaction, 
    l.pid, 
    l.mode, 
    l.granted	
FROM 
    pg_locks l 
JOIN 
    pg_stat_all_tables t ON l.relation = t.relid 
WHERE mode='RowShareLock'