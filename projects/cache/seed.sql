CREATE SCHEMA IF NOT EXISTS "cache";

CREATE Table cache.tblDummy
(
id serial primary key,
p_id int,
c_id int,
entry_time timestamp,
entry_value int,
description varchar(50)  
);

CREATE INDEX ON cache.tblDummy(c_id);