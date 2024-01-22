-- Query to filter based on a JSON field
SELECT * FROM jsons.json_test WHERE data_json->>'city' = 'New York';

-- Query to filter based on a JSONB field
SELECT * FROM jsons.json_test WHERE data_jsonb->>'city' = 'San Francisco';