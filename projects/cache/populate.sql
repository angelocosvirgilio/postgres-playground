/*
DO $$

DECLARE
    random_value integer:= 1;
BEGIN
    FOR p_id_ctr IN 1..10000 BY 1 LOOP               
        FOR c_id_ctr IN 1..200 BY 1 LOOP                                 
            random_value = (( random() * 75 ) + 25);
            INSERT INTO cache.tblDummy (p_id,c_id,entry_time, entry_value, description )
                VALUES (p_id_ctr,c_id_ctr,'now', random_value, CONCAT('Description for :',p_id_ctr, c_id_ctr));
        END LOOP ;
    END LOOP ;                      
END $$;
*/

INSERT INTO cache.tblDummy (p_id,c_id,entry_time, entry_value, description )
select a.aid, b.bid, 'now'::timestamp, (( random() * 75 ) + 25)::int, CONCAT('Description for :',a.aid, '_',b.bid)
from generate_series(1, 10000) a (aid)
cross join generate_series(1, 200) b (bid);