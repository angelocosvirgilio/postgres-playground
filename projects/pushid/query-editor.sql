WITH vars AS (
    SELECT now() AS ts
)
select ts, extract(epoch from ts), "pushid"."pushid_encode_date"('mu', ts),
"pushid"."pushid_decode_date"('mu',"pushid"."pushid_encode_date"('mu', ts))
from vars;
/*
select "pushid"."pushid_encode_date"('mu');

select "pushid"."pushid_decode_date"('mu',"pushid"."pushid_encode_date"('mu'))
*/
