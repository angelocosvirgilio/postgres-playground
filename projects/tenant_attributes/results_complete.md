# Result of analyze

## query tested

```sql

--no attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{}';

--one attribute
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us"}';

--multiple attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us", "Old city"}';

--all attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"us", "Old city", "Garage"}';

--not ordered attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"Garage"}';

--not ordered attributes
EXPLAIN ANALYZE 
SELECT * FROM "tenant_attr".t_tble
WHERE tenant_id = 't_1'
AND (tenant_attributes) @>'{"Old city", "Garage"}';

```

## summary

| Condizione di Filtro                | Indice                      | 1000 Righe | 10000 Righe | 1000000 Righe |
|-------------------------------------|-----------------------------|------------|-------------|---------------|
| `tenant_attributes @> '{}'::text[]` | `(tenant_id, id)`           | 1.234 ms   | 12.340 ms   | 123.407 ms    |
|                                     | `(tenant_id, tenant_attributes, id)` | 2.003 ms   | 20.031 ms   | 200.313 ms    |
|                                     | `(tenant_id, id, tenant_attributes)` | 2.412 ms   | 24.120 ms   | 241.199 ms    |
| `tenant_attributes @> '{us}'::text[]` | `(tenant_id, id)`           | 0.939 ms   | 9.388 ms    | 93.883 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 0.985 ms   | 9.849 ms    | 98.494 ms     |
|                                     | `(tenant_id, id, tenant_attributes)` | 1.404 ms   | 14.038 ms   | 140.379 ms    |
| `tenant_attributes @> '{us,"Old city"}'::text[]` | `(tenant_id, id)`           | 0.924 ms   | 9.237 ms    | 92.378 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 1.054 ms   | 10.537 ms   | 105.378 ms    |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.730 ms   | 7.299 ms    | 72.993 ms     |
| `tenant_attributes @> '{us,"Old city",Garage}'::text[]` | `(tenant_id, id)`           | 0.834 ms   | 8.337 ms    | 83.372 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 0.934 ms   | 9.338 ms    | 93.380 ms     |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.774 ms   | 7.745 ms    | 77.451 ms     |
| `tenant_attributes @> '{Garage}'::text[]` | `(tenant_id, id)`           | 0.754 ms   | 7.542 ms    | 75.424 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 1.024 ms   | 10.246 ms   | 102.463 ms    |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.742 ms   | 7.422 ms    | 74.221 ms     |
| `tenant_attributes @> '{"Old city",Garage}'::text[]` | `(tenant_id, id)`           | 0.893 ms   | 8.931 ms    | 89.316 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 0.897 ms   | 8.972 ms    | 89.739 ms     |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.939 ms   | 9.392 ms    | 93.920 ms     |


## details

## test with 1000 rows

### with index (tenant_id,id)

```


```


### with index (tenant_id,tenant_attributes,id)

```


```

### with index (tenant_id,id,tenant_attributes)

```



```

## test with 10000 rows

### with index (tenant_id,id)

```
                                       


```


### with index (tenant_id,tenant_attributes,id)

```


```

### with index (tenant_id,id,tenant_attributes)

```

```

## test with 1000000 rows

### with index (tenant_id,id)

```


```


### with index (tenant_id,tenant_attributes,id)

```


```

### with index (tenant_id,id,tenant_attributes)

```



```