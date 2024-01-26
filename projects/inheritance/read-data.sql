/*
If we want to find out the exact table in the hierarchy 
where a specific row belongs (the equivalent of obj.getClass().getName() in java) 
we can do by specifying the tableoid special column (oid of the respective table in pgclass), 
casted to regclass which gives the full table name:
*/

SELECT tableoid::regclass, * FROM inherit.cars;

SELECT tableoid::regclass, * FROM inherit.boats;

SELECT tableoid::regclass, * FROM inherit.rental;

/*
Since the rows of boats and cars are also instances of rental it is natural that they appear as rows of rental. 
If we want only rows exclusive of rental (in other words the rows inserted directly to rental) 
we do it using the ONLY keyword as follows:
*/

SELECT tableoid::regclass, * FROM ONLY inherit.rental;