CREATE TABLE mvc.test_multi (a INT, b INT);
INSERT INTO mvc.test_multi SELECT i, i FROM generate_series(1, 1000) AS i;
ANALYZE mvc.test_multi;
CREATE STATISTICS mvc.test_multi_stats (dependencies) ON a, b FROM mvc.test_multi;
ANALYZE mvc.test_multi;