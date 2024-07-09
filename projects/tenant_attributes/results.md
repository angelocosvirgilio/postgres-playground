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

## test with 1000 rows

### with index (tenant_id,id)

```
                                              QUERY PLAN                                              
------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=323 width=56) (actual time=0.030..0.199 rows=323 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 677
 Planning Time: 0.933 ms
 Execution Time: 0.276 ms
(5 rows)

                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=18 width=56) (actual time=0.024..0.171 rows=23 loops=1)
   Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 977
 Planning Time: 0.058 ms
 Execution Time: 0.177 ms
(5 rows)

                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.252..0.252 rows=0 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 1000
 Planning Time: 0.030 ms
 Execution Time: 0.258 ms
(5 rows)

                                            QUERY PLAN                                             
---------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.188..0.188 rows=0 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 1000
 Planning Time: 0.034 ms
 Execution Time: 0.194 ms
(5 rows)

                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=17 width=56) (actual time=0.011..0.230 rows=16 loops=1)
   Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 984
 Planning Time: 0.035 ms
 Execution Time: 0.236 ms
(5 rows)

                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.009..0.210 rows=2 loops=1)
   Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 998
 Planning Time: 0.030 ms
 Execution Time: 0.214 ms
(5 rows)

```


### with index (tenant_id,tenant_attributes,id)

```
                                              QUERY PLAN                                              
------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=323 width=56) (actual time=0.010..0.179 rows=323 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 677
 Planning Time: 0.705 ms
 Execution Time: 0.209 ms
(5 rows)

                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=18 width=56) (actual time=0.024..0.236 rows=23 loops=1)
   Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 977
 Planning Time: 0.046 ms
 Execution Time: 0.243 ms
(5 rows)

                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.179..0.179 rows=0 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 1000
 Planning Time: 0.113 ms
 Execution Time: 0.184 ms
(5 rows)

                                            QUERY PLAN                                             
---------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.275..0.275 rows=0 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 1000
 Planning Time: 0.025 ms
 Execution Time: 0.279 ms
(5 rows)

                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=17 width=56) (actual time=0.007..0.160 rows=16 loops=1)
   Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 984
 Planning Time: 0.025 ms
 Execution Time: 0.165 ms
(5 rows)

                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.006..0.200 rows=2 loops=1)
   Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 998
 Planning Time: 0.020 ms
 Execution Time: 0.204 ms
(5 rows)

```

### with index (tenant_id,id,tenant_attributes)

```
                                              QUERY PLAN                                              
------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=323 width=56) (actual time=0.010..0.190 rows=323 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 677
 Planning Time: 0.407 ms
 Execution Time: 0.220 ms
(5 rows)

                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=18 width=56) (actual time=0.022..0.171 rows=23 loops=1)
   Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 977
 Planning Time: 0.035 ms
 Execution Time: 0.177 ms
(5 rows)

                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.152..0.152 rows=0 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 1000
 Planning Time: 0.021 ms
 Execution Time: 0.156 ms
(5 rows)

                                            QUERY PLAN                                             
---------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.157..0.157 rows=0 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 1000
 Planning Time: 0.025 ms
 Execution Time: 0.162 ms
(5 rows)

                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=17 width=56) (actual time=0.007..0.160 rows=16 loops=1)
   Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 984
 Planning Time: 0.024 ms
 Execution Time: 0.165 ms
(5 rows)

                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..26.00 rows=1 width=56) (actual time=0.008..0.151 rows=2 loops=1)
   Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 998
 Planning Time: 0.026 ms
 Execution Time: 0.156 ms
(5 rows)


```

## test with 10000 rows

### with index (tenant_id,id)

```
                                       
                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=625.36..2182.91 rows=33170 width=54) (actual time=9.804..19.972 rows=33242 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{}'::text[])
   Heap Blocks: exact=1060
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..617.07 rows=33170 width=0) (actual time=8.937..8.938 rows=33242 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.622 ms
 Execution Time: 31.557 ms
(8 rows)

                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=617.49..2175.04 rows=1673 width=54) (actual time=2.594..10.808 rows=1675 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{us}'::text[])
   Rows Removed by Filter: 31567
   Heap Blocks: exact=1060
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..617.07 rows=33170 width=0) (actual time=2.460..2.460 rows=33242 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.075 ms
 Execution Time: 10.891 ms
(9 rows)

                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=617.09..2174.64 rows=75 width=54) (actual time=1.842..10.189 rows=79 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{us,"Old city"}'::text[])
   Rows Removed by Filter: 33163
   Heap Blocks: exact=1060
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..617.07 rows=33170 width=0) (actual time=1.610..1.611 rows=33242 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.083 ms
 Execution Time: 10.236 ms
(9 rows)

                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=617.07..2174.62 rows=4 width=54) (actual time=2.913..10.060 rows=6 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{us,"Old city",Garage}'::text[])
   Rows Removed by Filter: 33236
   Heap Blocks: exact=1060
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..617.07 rows=33170 width=0) (actual time=1.542..1.543 rows=33242 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.060 ms
 Execution Time: 10.103 ms
(9 rows)

                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=617.50..2175.05 rows=1743 width=54) (actual time=1.627..10.484 rows=1667 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{Garage}'::text[])
   Rows Removed by Filter: 31575
   Heap Blocks: exact=1060
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..617.07 rows=33170 width=0) (actual time=1.523..1.523 rows=33242 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.072 ms
 Execution Time: 10.609 ms
(9 rows)

                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=617.09..2174.64 rows=79 width=54) (actual time=1.712..10.633 rows=75 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{"Old city",Garage}'::text[])
   Rows Removed by Filter: 33167
   Heap Blocks: exact=1060
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..617.07 rows=33170 width=0) (actual time=1.608..1.608 rows=33242 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.181 ms
 Execution Time: 10.710 ms
(9 rows)

```


### with index (tenant_id,tenant_attributes,id)

```

                                                 QUERY PLAN                                                  
-------------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=33170 width=54) (actual time=0.010..17.993 rows=33242 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 66758
 Planning Time: 0.549 ms
 Execution Time: 18.759 ms
(5 rows)

                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=1673 width=54) (actual time=0.058..19.473 rows=1675 loops=1)
   Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 98325
 Planning Time: 0.050 ms
 Execution Time: 19.532 ms
(5 rows)

                                              QUERY PLAN                                               
-------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=75 width=54) (actual time=0.264..16.310 rows=79 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 99921
 Planning Time: 0.076 ms
 Execution Time: 16.330 ms
(5 rows)

                                             QUERY PLAN                                              
-----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=4 width=54) (actual time=2.434..17.232 rows=6 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 99994
 Planning Time: 0.068 ms
 Execution Time: 17.247 ms
(5 rows)

                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=1743 width=54) (actual time=0.010..16.622 rows=1667 loops=1)
   Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 98333
 Planning Time: 0.063 ms
 Execution Time: 16.674 ms
(5 rows)

                                              QUERY PLAN                                               
-------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=79 width=54) (actual time=0.010..15.835 rows=75 loops=1)
   Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 99925
 Planning Time: 0.055 ms
 Execution Time: 15.857 ms
(5 rows)

```

### with index (tenant_id,id,tenant_attributes)

```
                                                 QUERY PLAN                                                  
--------------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=33170 width=54) (actual time=0.175..116.299 rows=33242 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 66758
 Planning Time: 15.740 ms
 Execution Time: 118.079 ms
(5 rows)

                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=1673 width=54) (actual time=0.085..18.765 rows=1675 loops=1)
   Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 98325
 Planning Time: 0.104 ms
 Execution Time: 18.830 ms
(5 rows)

                                              QUERY PLAN                                               
-------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=75 width=54) (actual time=0.278..20.026 rows=79 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 99921
 Planning Time: 0.067 ms
 Execution Time: 20.055 ms
(5 rows)

                                             QUERY PLAN                                              
-----------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=4 width=54) (actual time=3.416..21.554 rows=6 loops=1)
   Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 99994
 Planning Time: 0.088 ms
 Execution Time: 21.574 ms
(5 rows)

                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=1743 width=54) (actual time=0.009..17.599 rows=1667 loops=1)
   Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 98333
 Planning Time: 0.069 ms
 Execution Time: 17.656 ms
(5 rows)

                                              QUERY PLAN                                               
-------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..2560.00 rows=79 width=54) (actual time=0.010..16.856 rows=75 loops=1)
   Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 99925
 Planning Time: 0.059 ms
 Execution Time: 16.878 ms
(5 rows)


```

## test with 1000000 rows

### with index (tenant_id,id)

```
                                                           QUERY PLAN                                                            
---------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on t_tble  (cost=6807.41..23808.77 rows=363224 width=55) (actual time=23.059..114.675 rows=362877 loops=1)
   Recheck Cond: (tenant_id = 't_1'::text)
   Filter: (tenant_attributes @> '{}'::text[])
   Heap Blocks: exact=11553
   ->  Bitmap Index Scan on ttble_idx  (cost=0.00..6716.61 rows=363224 width=0) (actual time=21.582..21.583 rows=362877 loops=1)
         Index Cond: (tenant_id = 't_1'::text)
 Planning Time: 0.426 ms
 Execution Time: 123.407 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..21100.50 rows=17350 width=55) (actual time=4.817..82.967 rows=18061 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=7229 width=55) (actual time=0.496..70.932 rows=6020 loops=3)
         Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357313
 Planning Time: 0.072 ms
 Execution Time: 93.883 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19444.20 rows=787 width=55) (actual time=0.419..92.292 rows=827 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=328 width=55) (actual time=0.282..86.930 rows=276 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363058
 Planning Time: 0.068 ms
 Execution Time: 92.378 ms
(8 rows)

                                                      QUERY PLAN                                                       
-----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19369.60 rows=41 width=55) (actual time=3.186..83.337 rows=48 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=17 width=55) (actual time=2.987..78.340 rows=16 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363317
 Planning Time: 0.079 ms
 Execution Time: 83.372 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..21239.70 rows=18742 width=55) (actual time=0.132..74.867 rows=18986 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=7809 width=55) (actual time=0.135..68.803 rows=6329 loops=3)
         Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357005
 Planning Time: 0.079 ms
 Execution Time: 75.424 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19450.50 rows=850 width=55) (actual time=0.134..89.242 rows=875 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=354 width=55) (actual time=0.316..82.992 rows=292 loops=3)
         Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363042
 Planning Time: 0.069 ms
 Execution Time: 89.316 ms
(8 rows)

```


### with index (tenant_id,tenant_attributes,id)

```

                                                   QUERY PLAN                                                    
-----------------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..27903.00 rows=363224 width=55) (actual time=0.019..192.341 rows=362877 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 727123
 Planning Time: 1.739 ms
 Execution Time: 200.313 ms
(5 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..21100.50 rows=17350 width=55) (actual time=0.689..97.939 rows=18061 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=7229 width=55) (actual time=0.140..88.585 rows=6020 loops=3)
         Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357313
 Planning Time: 0.061 ms
 Execution Time: 98.494 ms
(8 rows)

                                                        QUERY PLAN                                                        
--------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19444.20 rows=787 width=55) (actual time=0.464..105.256 rows=827 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=328 width=55) (actual time=0.462..100.129 rows=276 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363058
 Planning Time: 0.073 ms
 Execution Time: 105.378 ms
(8 rows)

                                                      QUERY PLAN                                                       
-----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19369.60 rows=41 width=55) (actual time=3.690..93.343 rows=48 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=17 width=55) (actual time=2.922..87.621 rows=16 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363317
 Planning Time: 0.075 ms
 Execution Time: 93.380 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..21239.70 rows=18742 width=55) (actual time=0.152..101.780 rows=18986 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=7809 width=55) (actual time=0.127..94.268 rows=6329 loops=3)
         Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357005
 Planning Time: 0.071 ms
 Execution Time: 102.463 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19450.50 rows=850 width=55) (actual time=0.876..89.666 rows=875 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=354 width=55) (actual time=0.459..81.003 rows=292 loops=3)
         Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363042
 Planning Time: 0.090 ms
 Execution Time: 89.739 ms
(8 rows)

```

### with index (tenant_id,id,tenant_attributes)

```

                                                   QUERY PLAN                                                    
-----------------------------------------------------------------------------------------------------------------
 Seq Scan on t_tble  (cost=0.00..27903.00 rows=363224 width=55) (actual time=0.013..231.671 rows=362877 loops=1)
   Filter: ((tenant_attributes @> '{}'::text[]) AND (tenant_id = 't_1'::text))
   Rows Removed by Filter: 727123
 Planning Time: 0.567 ms
 Execution Time: 241.199 ms
(5 rows)

                                                         QUERY PLAN                                                         
----------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..21100.50 rows=17350 width=55) (actual time=0.363..139.583 rows=18061 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=7229 width=55) (actual time=0.231..124.822 rows=6020 loops=3)
         Filter: ((tenant_attributes @> '{us}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357313
 Planning Time: 0.101 ms
 Execution Time: 140.379 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19444.20 rows=787 width=55) (actual time=0.427..72.933 rows=827 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=328 width=55) (actual time=0.310..67.762 rows=276 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363058
 Planning Time: 0.107 ms
 Execution Time: 72.993 ms
(8 rows)

                                                      QUERY PLAN                                                       
-----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19369.60 rows=41 width=55) (actual time=2.468..77.425 rows=48 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=17 width=55) (actual time=4.094..70.906 rows=16 loops=3)
         Filter: ((tenant_attributes @> '{us,"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363317
 Planning Time: 0.068 ms
 Execution Time: 77.451 ms
(8 rows)

                                                        QUERY PLAN                                                         
---------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..21239.70 rows=18742 width=55) (actual time=0.135..73.767 rows=18986 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=7809 width=55) (actual time=0.137..68.273 rows=6329 loops=3)
         Filter: ((tenant_attributes @> '{Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 357005
 Planning Time: 0.056 ms
 Execution Time: 74.221 ms
(8 rows)

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..19450.50 rows=850 width=55) (actual time=0.162..93.825 rows=875 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on t_tble  (cost=0.00..18365.50 rows=354 width=55) (actual time=0.332..86.217 rows=292 loops=3)
         Filter: ((tenant_attributes @> '{"Old city",Garage}'::text[]) AND (tenant_id = 't_1'::text))
         Rows Removed by Filter: 363042
 Planning Time: 0.055 ms
 Execution Time: 93.920 ms
(8 rows)

```