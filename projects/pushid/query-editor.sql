WITH vars AS (
    SELECT now() AS ts
)
select ts, 
       extract(epoch from ts), 
       "pushid"."pushid_encode_date"('ms', ts),
       "pushid"."pushid_decode_date"('ms',"pushid"."pushid_encode_date"('ms', ts)),
       TO_TIMESTAMP("pushid"."pushid_decode_date"('ms',"pushid"."pushid_encode_date"('ms', ts))/1000::float),
       "pushid"."pushid_generate_v1"('ms', ts)       
from vars;
/*
select "pushid"."pushid_encode_date"('ms');

select "pushid"."pushid_decode_date"('ms',"pushid"."pushid_encode_date"('ms'))
*/
