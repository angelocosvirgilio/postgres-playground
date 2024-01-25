CREATE SCHEMA IF NOT EXISTS "inherit_poly";

CREATE TABLE IF NOT EXISTS "inherit_poly".rental (
    id integer NOT NULL,
    customerid integer NOT NULL,
    vehicleno text,
    datestart date NOT NULL,
    dateend date
); 


CREATE TABLE IF NOT EXISTS "inherit_poly".cars(
	driv_lic_no TEXT NOT NULL
) INHERITS ("inherit_poly".rental);


CREATE TABLE IF NOT EXISTS "inherit_poly".boats ( 
	sail_cert_no TEXT
) INHERITS ("inherit_poly".rental);