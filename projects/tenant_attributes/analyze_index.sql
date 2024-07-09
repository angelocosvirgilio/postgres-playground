--no attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{}'
AND id>1000;

--one attribute
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us"}'
AND id>1000;

--multiple attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us", "Old city"}'
AND id>1000;

--all attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us", "Old city", "Garage"}'
AND id>1000;


--not ordered attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"Garage"}'
AND id>1000;

--not ordered attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"Old city", "Garage"}'
AND id>1000;
