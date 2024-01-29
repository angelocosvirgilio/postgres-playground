CREATE SCHEMA IF NOT EXISTS "poly";

CREATE OR REPLACE FUNCTION poly.max( arg1 ANYELEMENT, arg2 ANYELEMENT ) 
    RETURNS ANYELEMENT AS $$
  BEGIN

    IF( arg1 > arg2 ) THEN
      RETURN( arg1 );
    ELSE
      RETURN( arg2 );
    END IF;

  END;
$$ LANGUAGE 'plpgsql';


CREATE TABLE IF NOT EXISTS "poly".ptable (
  id int,
  value anyelement
);


CREATE FUNCTION poly.my_custom_at(text, text)
RETURNS text AS 'SELECT CONCAT($1,''@'',$2)' LANGUAGE SQL;

CREATE OPERATOR @ (
  LEFTARG = text,
  RIGHTARG = text,
  PROCEDURE = poly.my_custom_at
);

CREATE FUNCTION poly.local_concat(text, text)
RETURNS text AS 'SELECT CONCAT(''<local_concat> '',$1,''_'',$2,'' </local_concat>'')' LANGUAGE SQL;

CREATE OPERATOR poly.|| (
  LEFTARG = text,
  RIGHTARG = text,
  PROCEDURE = poly.local_concat
);

