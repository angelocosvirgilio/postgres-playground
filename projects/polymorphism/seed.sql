CREATE SCHEMA IF NOT EXISTS "poly";

/** poly function */
CREATE OR REPLACE FUNCTION poly.get_the_max( arg1 ANYELEMENT, arg2 ANYELEMENT ) 
    RETURNS ANYELEMENT AS $$
  BEGIN

    IF( arg1 > arg2 ) THEN
      RETURN( arg1 );
    ELSEIF( arg1 < arg2 ) THEN
      RETURN( arg2 );
    ELSE 
      RETURN (NULL);
    END IF;

  END;
$$ LANGUAGE 'plpgsql';


/** custom operator */
CREATE FUNCTION poly.my_custom_at(text, text)
RETURNS text AS 'SELECT CONCAT($1,''@'',$2)' LANGUAGE SQL;

CREATE OPERATOR @ (
  LEFTARG = text,
  RIGHTARG = text,
  PROCEDURE = poly.my_custom_at
);


/** operator overloading */
CREATE FUNCTION poly.local_concat(text, text)
RETURNS text AS 'SELECT CONCAT(''<local_concat> '',$1,''_'',$2,'' </local_concat>'')' LANGUAGE SQL;

CREATE OPERATOR poly.|| (
  LEFTARG = text,
  RIGHTARG = text,
  PROCEDURE = poly.local_concat
);

/*** fuction overloading ***/
create or replace function poly.get_my_input(
	int_input integer
)
returns integer 
language plpgsql
as $$
declare 
	ret_value integer; 
begin
	ret_value= int_input;
	return ret_value;
end; $$;

create or replace function poly.get_my_input(
	int_input text
)
returns text 
language plpgsql
as $$
declare 
	ret_value text; 
begin
	ret_value= int_input;
	return ret_value;
end; $$;



create or replace function poly.get_my_input(
	int_input text,
    your_date date
)
returns RECORD 
language plpgsql
as $$
declare 
	
begin
	return (int_input, your_date);
end; $$;


create or replace function poly.optional_inputs(
	int_input text,
    your_date date DEFAULT CURRENT_DATE 
)
returns RECORD 
language plpgsql
as $$
declare 
	
begin
	return (int_input, your_date);
end; $$;
