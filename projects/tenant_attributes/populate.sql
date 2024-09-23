WITH 
  -- SEED CONFIGURATION AND STATIC DATA
  -- (we use this as source for dictionary-based randomic selections)
  "seed_config"("doc") AS ( VALUES ('{
    "entries_tot": 50,
    "tenants_tot": 5,   
    "null_values_in_array_possibilities": 15, 
    "countries": ["it","us","fr","es","de"],        
    "cities": [      
      "Marvelous city",
      "Valley",
      "Coruxant",
      "City new",
      "Old city",
      "Ancient city",
      "Mountain city"      
    ],
    "locations": [
      "Old Office",
      "New Office",
      "Warehouse",
      "Garage"
    ]
  }'::json))

  , "generated_entries_data" AS (
    SELECT 
    -- tenants
    ( floor(random()* (SELECT ("doc"->>'tenants_tot')::INT FROM "seed_config")+1 )) AS "tenant_suffix",
    --(CONCAT('t_', floor(random()*("doc"->'entries_tot')::INT ) )) AS "tenant_id",    
    --countries    
    (
      SELECT ARRAY(SELECT json_array_elements_text("doc"->'countries')) FROM "seed_config"
    ) AS "countries_values", 
    (
        SELECT json_array_length("doc"->'countries') FROM "seed_config"
    )::INT AS "countries_length", 
    -- cities
    (
      SELECT ARRAY(SELECT json_array_elements_text("doc"->'cities')) FROM "seed_config"
    ) AS "cities_values", 
    (
        SELECT json_array_length("doc"->'cities') FROM "seed_config"
    )::INT AS "cities_length",
    -- locations   
    (
      SELECT ARRAY(SELECT json_array_elements_text("doc"->'locations')) FROM "seed_config"
    ) AS "locations_values", 
    (
        SELECT json_array_length("doc"->'locations') FROM "seed_config"
    )::INT AS "locations_length",  
    (
      SELECT ("doc" ->> 'null_values_in_array_possibilities')::INT FROM "seed_config"
    )::INT AS "null_values_in_array_possibilities" 
    FROM generate_series(1, (
      SELECT ("doc" ->> 'entries_tot')::INT FROM "seed_config"
    ))
  )

  , "insert_entries_values" AS (
    SELECT 
        (CONCAT('t_', "tenant_suffix")) as "tenant_id",      
        ("countries_values")[floor(random() * ("countries_length" + "null_values_in_array_possibilities"))] AS "country", 
        ("cities_values")[floor(random() * ("cities_length" + "null_values_in_array_possibilities"))] AS "city" ,
        ("locations_values")[floor(random() * ("locations_length" + "null_values_in_array_possibilities"))] AS "location"        
    FROM "generated_entries_data"
  )

  

--SELECT *, concat('tenant ', "tenant_id", ' with attributes  ', "country",' ', "city",' ', "location") FROM "insert_entries_values"

INSERT INTO "tenant_attr".t_tble (
    tenant_id,
    tenant_attributes,
    info
)
SELECT "tenant_id",
        array_remove(ARRAY["country","city","location"],null),        
        ARRAY["country","city","location"]
       -- concat('tenant ', "tenant_id", ' with attributes  ', concat_ws(',',"country","city","location")) 
FROM "insert_entries_values";

SELECT * FROM "tenant_attr".t_tble
