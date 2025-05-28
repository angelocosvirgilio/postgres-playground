CREATE TABLE test_or (a INT, b INT);
INSERT INTO test_or SELECT i % 10, i % 10 FROM generate_series(1, 1000) AS i;
ANALYZE test_or;
CREATE STATISTICS test_or_stats (mcv) ON a, b FROM test_or;
ANALYZE test_or;