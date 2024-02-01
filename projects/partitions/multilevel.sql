CREATE TABLE partitions.customers (id INTEGER, status TEXT, arr NUMERIC) PARTITION BY LIST(status);

    CREATE TABLE partitions.cust_active PARTITION OF partitions.customers FOR VALUES IN ('ACTIVE','RECURRING','REACTIVATED') PARTITION BY RANGE(arr);
        CREATE TABLE partitions.cust_arr_small PARTITION OF partitions.cust_active FOR VALUES FROM (MINVALUE) TO (101) PARTITION BY HASH(id);
            CREATE TABLE partitions.cust_part11 PARTITION OF partitions.cust_arr_small FOR VALUES WITH (modulus 2, remainder 0);
            CREATE TABLE partitions.cust_part12 PARTITION OF partitions.cust_arr_small FOR VALUES WITH (modulus 2, remainder 1);

    CREATE TABLE partitions.cust_other PARTITION OF partitions.customers DEFAULT PARTITION BY RANGE(arr);
        CREATE TABLE partitions.cust_arr_large PARTITION OF partitions.cust_other DEFAULT FOR VALUES FROM (101) TO (MAXVALUE) PARTITION BY HASH(id);
            CREATE TABLE partitions.cust_part21 PARTITION OF partitions.cust_arr_large FOR VALUES WITH (modulus 2, remainder 0);
            CREATE TABLE partitions.cust_part22 PARTITION OF partitions.cust_arr_large FOR VALUES WITH (modulus 2, remainder 1);


INSERT INTO partitions.customers VALUES (1,'ACTIVE',100), (2,'RECURRING',20), (3,'REACTIVATED',38), (4,'EXPIRED',144), (5,'ACTIVE',200), (6,'EXPIRED',80);


SELECT tableoid::regclass,* FROM partitions.customers;
