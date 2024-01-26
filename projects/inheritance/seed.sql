CREATE SCHEMA IF NOT EXISTS "inherit";

CREATE TABLE IF NOT EXISTS "inherit".rental (
    id integer NOT NULL,
    customerid integer NOT NULL,
    vehicleno text,
    datestart date NOT NULL,
    dateend date
); 


CREATE TABLE IF NOT EXISTS "inherit".cars(
	driv_lic_no TEXT NOT NULL
) INHERITS ("inherit".rental);


CREATE TABLE IF NOT EXISTS "inherit".boats ( 
	sail_cert_no TEXT
) INHERITS ("inherit".rental);