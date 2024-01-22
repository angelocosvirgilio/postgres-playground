CREATE SCHEMA IF NOT EXISTS "jsons";

CREATE TABLE IF NOT EXISTS "jsons"."json_test" (
    id serial PRIMARY KEY,
    data_json JSON,
    data_jsonb JSONB
);
