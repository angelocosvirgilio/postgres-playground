CREATE TABLE "cross-data-hash".tab_text (val TEXT);
CREATE TABLE "cross-data-hash".tab_varchar (val VARCHAR);

INSERT INTO "cross-data-hash".tab_text VALUES ('a'), ('b'), ('c');
INSERT INTO "cross-data-hash".tab_varchar VALUES ('b'), ('c'), ('d');

-- DISTINCT su unione
EXPLAIN ANALYZE
SELECT DISTINCT val FROM (
  SELECT val FROM "cross-data-hash".tab_text
  UNION
  SELECT val FROM "cross-data-hash".tab_varchar
) AS u;