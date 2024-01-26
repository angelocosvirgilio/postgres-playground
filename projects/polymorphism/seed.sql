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