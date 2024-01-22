SELECT 
    id,
    pg_column_size(data_json) AS size_json,
    pg_column_size(data_jsonb) AS size_jsonb
FROM jsons.json_test;