CREATE TABLE "cross-data-hash".t1 (
  id SERIAL PRIMARY KEY,
  cod_text TEXT
);

CREATE TABLE "cross-data-hash".t2 (
  id SERIAL PRIMARY KEY,
  cod_varchar VARCHAR
);

INSERT INTO "cross-data-hash".t1 (cod_text) VALUES ('A'), ('B'), ('C');
INSERT INTO "cross-data-hash".t2 (cod_varchar) VALUES ('B'), ('C'), ('D');


EXPLAIN ANALYZE
SELECT t1.*, t2.*
FROM "cross-data-hash".t1
JOIN "cross-data-hash".t2 ON t1.cod_text = t2.cod_varchar;