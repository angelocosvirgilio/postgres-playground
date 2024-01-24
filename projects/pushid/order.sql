DROP TABLE IF EXISTS "pushid"."testtable";

CREATE TABLE IF NOT EXISTS "pushid"."testtable" (
    originalData TIMESTAMPTZ,
    binaryid BYTEA,
    textid VARCHAR(20)
);

INSERT INTO "pushid"."testtable"
VALUES ('2024-01-10 10:10:59.005121',(select "value"::BYTEA from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005121')),(select "value"::VARCHAR(20) from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005121'))),
       ('2024-01-10 10:10:59.005124',(select "value"::BYTEA from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005124')),(select "value"::VARCHAR(20) from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005124'))),
       ('2024-01-10 10:10:59.005123',(select "value"::BYTEA from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005123')),(select "value"::VARCHAR(20) from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005123'))),
       ('2024-01-10 10:10:59.005122',(select "value"::BYTEA from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005122')),(select "value"::VARCHAR(20) from "pushid"."pushid_generate_v1"('mu', '2024-01-10 10:10:59.005122')))