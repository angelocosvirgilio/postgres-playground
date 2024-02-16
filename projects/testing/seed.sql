CREATE SCHEMA IF NOT EXISTS "testing";

CREATE TABLE IF NOT EXISTS "testing"."test_table" (
    id INT PRIMARY KEY,
    uname varchar(20),
    date_of_birth date,
    country varchar(2)
);


CREATE OR REPLACE FUNCTION "testing".insert_record(
    p_id INT,
    p_uname VARCHAR(20),
    p_date_of_birth DATE,
    p_country VARCHAR(2)
) RETURNS INT AS
$$
DECLARE
    inserted_id INT;
BEGIN
    -- Check if the record already exists
    IF EXISTS (
        SELECT 1 FROM testing.test_table 
        WHERE uname = p_uname 
        AND date_of_birth = p_date_of_birth 
        AND country = p_country
    ) THEN
        -- Throw an exception if the record already exists
        RAISE EXCEPTION 'Record already exists';
    ELSE
        -- Insert the record if it doesn't exist
        INSERT INTO testing.test_table (id, uname, date_of_birth, country)
        VALUES (p_id, p_uname, p_date_of_birth, p_country)
        RETURNING id INTO inserted_id;
    END IF;
    
    RETURN inserted_id;
END;
$$
LANGUAGE plpgsql;

-- Function to update a record in test_table and return the updated record
CREATE OR REPLACE FUNCTION "testing".update_record(
    p_id INT,
    p_uname VARCHAR(20),
    p_date_of_birth DATE,
    p_country VARCHAR(2)
) RETURNS testing.test_table AS
$$
DECLARE
    updated_record testing.test_table;
BEGIN
    UPDATE testing.test_table
    SET uname = p_uname,
        date_of_birth = p_date_of_birth,
        country = p_country
    WHERE id = p_id
    RETURNING * INTO updated_record;
    
    RETURN updated_record;
END;
$$
LANGUAGE plpgsql;

-- Function to delete a record from test_table by id and return the deleted id
CREATE OR REPLACE FUNCTION "testing".delete_record_by_id(p_id INT) 
RETURNS testing.test_table AS
$$
DECLARE
    deleted_record testing.test_table;
BEGIN
    DELETE FROM testing.test_table WHERE id = p_id
    RETURNING * INTO deleted_record;
    
    RETURN deleted_record;
END;
$$
LANGUAGE plpgsql;