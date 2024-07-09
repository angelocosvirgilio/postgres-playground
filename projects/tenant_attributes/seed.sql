CREATE SCHEMA IF NOT EXISTS "tenant_attr";

CREATE TABLE IF NOT EXISTS "tenant_attr".t_tble (
    id serial,
    tenant_id TEXT NOT NULL,
    tenant_attributes TEXT[] DEFAULT '{}',
    info TEXT
); 


