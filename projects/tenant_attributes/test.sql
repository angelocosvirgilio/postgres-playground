--no attributes
--SELECT cardinality(ARRAY[]::TEXT[])

SELECT *  
FROM "tenant_attr".t_tble
WHERE cardinality(tenant_attributes) = 0
--order by 1
