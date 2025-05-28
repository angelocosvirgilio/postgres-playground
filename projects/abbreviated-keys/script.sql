SET client_min_messages = log;
SET log_executor_stats = on;

EXPLAIN ANALYZE 
SELECT * FROM "abbrkeys".test_strings 
ORDER BY text_col;