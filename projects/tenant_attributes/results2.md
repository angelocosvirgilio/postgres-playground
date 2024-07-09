# Result of analyze

## query tested

```sql

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

```

## test with 1000000 rows

### with index (tenant_id,id)

```
                                                          QUERY PLAN                                                            
---------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=7711.10..25619.89 rows=363188 width=55) (actual time=63.272..150.672 rows=362877 loops=1)
   Recheck Cond: ((tenant_id = 't_1'::text) AND (id > 1000))
   Filter: (tenant_attributes @> '{}'::text[])
   Heap Blocks: exact=11553
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..7620.31 rows=363188 width=0) (actual time=61.879..61.879 rows=362877 loops=1)
         Index Cond: ((tenant_id = 't_1'::text) AND (id > 1000))
 Planning Time: 0.502 ms
 Execution Time: 158.768 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22235.72 rows=17348 width=55) (actual time=0.210..82.539 rows=18061 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=7228 width=55) (actual time=0.144..76.940 rows=6020 loops=3)
         Filter: ((tenant_attributes @> '{us}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357313
 Planning Time: 0.058 ms
 Execution Time: 83.163 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20579.52 rows=786 width=55) (actual time=0.416..87.340 rows=827 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=328 width=55) (actual time=0.271..77.147 rows=276 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363058
 Planning Time: 0.061 ms
 Execution Time: 87.405 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20505.02 rows=41 width=55) (actual time=2.580..74.569 rows=48 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=17 width=55) (actual time=1.781..69.521 rows=16 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363317
 Planning Time: 0.064 ms
 Execution Time: 74.593 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22375.02 rows=18741 width=55) (actual time=0.152..82.468 rows=18986 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=7809 width=55) (actual time=0.140..75.396 rows=6329 loops=3)
         Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357005
 Planning Time: 0.074 ms
 Execution Time: 83.076 ms
(8 rows)

                                                        QUERY PLAN                                                        
--------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20585.92 rows=850 width=55) (actual time=0.117..123.445 rows=875 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=354 width=55) (actual time=0.247..115.989 rows=292 loops=3)
         Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363042
 Planning Time: 0.071 ms
 Execution Time: 123.527 ms
(8 rows)

```


### with index (tenant_id,tenant_attributes,id)

```

                                                  QUERY PLAN                                                    
-----------------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..30628.00 rows=363188 width=55) (actual time=0.013..206.712 rows=362877 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 727123
 Planning Time: 0.476 ms
 Execution Time: 214.718 ms
(5 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22235.72 rows=17348 width=55) (actual time=0.289..69.619 rows=18061 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=7228 width=55) (actual time=0.134..64.190 rows=6020 loops=3)
         Filter: ((tenant_attributes @> '{us}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357313
 Planning Time: 0.076 ms
 Execution Time: 70.091 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20579.52 rows=786 width=55) (actual time=0.373..72.102 rows=827 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=328 width=55) (actual time=0.234..67.452 rows=276 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363058
 Planning Time: 0.066 ms
 Execution Time: 72.170 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20505.02 rows=41 width=55) (actual time=2.356..67.940 rows=48 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=17 width=55) (actual time=1.337..63.071 rows=16 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363317
 Planning Time: 0.083 ms
 Execution Time: 67.968 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22375.02 rows=18741 width=55) (actual time=0.121..78.512 rows=18986 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=7809 width=55) (actual time=0.129..73.253 rows=6329 loops=3)
         Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357005
 Planning Time: 0.073 ms
 Execution Time: 79.151 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20585.92 rows=850 width=55) (actual time=0.180..85.654 rows=875 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=354 width=55) (actual time=0.346..78.672 rows=292 loops=3)
         Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363042
 Planning Time: 0.099 ms
 Execution Time: 85.732 ms
(8 rows)

```

### with index (tenant_id,id,tenant_attributes)

```

                                                   QUERY PLAN                                                    
-----------------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..30628.00 rows=363188 width=55) (actual time=0.017..217.641 rows=362877 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 727123
 Planning Time: 0.825 ms
 Execution Time: 225.780 ms
(5 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22235.72 rows=17348 width=55) (actual time=0.283..73.518 rows=18061 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=7228 width=55) (actual time=0.123..68.173 rows=6020 loops=3)
         Filter: ((tenant_attributes @> '{us}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357313
 Planning Time: 0.068 ms
 Execution Time: 74.084 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20579.52 rows=786 width=55) (actual time=0.570..84.323 rows=827 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=328 width=55) (actual time=0.470..79.503 rows=276 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363058
 Planning Time: 0.089 ms
 Execution Time: 84.410 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20505.02 rows=41 width=55) (actual time=2.489..82.945 rows=48 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=17 width=55) (actual time=4.088..78.312 rows=16 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363317
 Planning Time: 0.142 ms
 Execution Time: 82.982 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22375.02 rows=18741 width=55) (actual time=0.169..87.166 rows=18986 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=7809 width=55) (actual time=0.144..81.549 rows=6329 loops=3)
         Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357005
 Planning Time: 0.065 ms
 Execution Time: 87.817 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..20585.92 rows=850 width=55) (actual time=0.191..82.315 rows=875 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..19500.92 rows=354 width=55) (actual time=0.206..77.533 rows=292 loops=3)
         Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363042
 Planning Time: 0.060 ms
 Execution Time: 82.389 ms
(8 rows)

```