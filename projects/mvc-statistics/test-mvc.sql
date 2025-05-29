CREATE TABLE mvc.test_mcv (a INT, b INT);
INSERT INTO mvc.test_mcv SELECT i % 10, i % 5 FROM generate_series(1, 1000) AS i;
ANALYZE mvc.test_mcv;
CREATE STATISTICS mvc.test_mcv_stats (mcv) ON a, b FROM mvc.test_mcv;
ANALYZE mvc.test_mcv;