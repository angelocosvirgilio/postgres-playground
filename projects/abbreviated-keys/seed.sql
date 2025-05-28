CREATE SCHEMA IF NOT EXISTS "abbrkeys";

CREATE TABLE "abbrkeys".test_strings (text_col TEXT);

INSERT INTO "abbrkeys".test_strings
SELECT md5(random()::text) FROM generate_series(1, 100000);