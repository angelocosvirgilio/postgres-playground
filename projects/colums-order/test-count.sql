-- Let’s do a count(*) and see how long it takes
SELECT count(*) FROM columns_order.t_broad;

-- the optimizer will go for a parallel sequential scan
explain SELECT count(*) FROM columns_order.t_broad;

/*
Let’s compare this to a count on the first column. You’ll see a small difference in performance. 
The reason is that count(*) has to check for the existence of the row 
while count(column) has to check if a NULL value is fed to the aggregate or not. 
In case of NULL the value has to be ignored:
*/

SELECT count(t_1) FROM columns_order.t_broad;


-- let’s see what happens if we access column number 100? The time to do that will differ significantly:
SELECT count(t_100) FROM columns_order.t_broad;

--  The performance is even worse if we do a count on column number 1000:
SELECT count(t_1000) FROM columns_order.t_broad;