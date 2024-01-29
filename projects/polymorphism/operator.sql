select 'a' @ 'b' as "at_operator";

select 'hello' OPERATOR(poly.||) 'world' as "local concat";

select 'hello' || 'world' as "global concat";
