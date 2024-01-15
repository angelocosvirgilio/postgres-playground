CREATE SCHEMA IF NOT EXISTS "columns_order";

-- create a table containing many columns

-- 1) generate the CREATE TABLE statement using generate_series
SELECT 'CREATE TABLE IF NOT EXISTS columns_order.t_broad ('
	|| string_agg('t_' || x
	|| ' varchar(10) DEFAULT ''a'' ', ', ') || ' )'
FROM generate_series(1, 1500) AS x

-- 2) call \gexec that is a really powerful thing: It treats the previous result as SQL input 
\gexec 