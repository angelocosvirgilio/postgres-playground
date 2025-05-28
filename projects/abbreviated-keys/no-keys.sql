SET enable_abbrev = off;

EXPLAIN ANALYZE 
SELECT * FROM "abbrkeys".test_strings 
ORDER BY text_col;