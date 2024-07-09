--no attributes
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{}';

--one attribute
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us"}';

--multiple attributes
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us", "Old city"}';

--all attributes
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us", "Old city", "Garage"}';


--not ordered attributes
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"Garage"}';

--not ordered attributes
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"Old city", "Garage"}';


--empty string research
SELECT * FROM "tenant_attr".t_tble
WHERE --tenant_id = 't_1'
--AND 
cardinality(tenant_attributes) = 0