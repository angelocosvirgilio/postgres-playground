DELETE FROM "jsons".json_test;
INSERT INTO "jsons".json_test (data_json, data_jsonb)
VALUES
    ('{"name": "John","age": 25, "city": "New York"}', '{"name": "John","age": 25, "city": "New York"}'),
    ('{"name": "Alice", "age": 30, "city": "San Francisco"}', '{"name": "Alice", "age": 30, "city": "San Francisco"}'),
    ('{"name": "Bob", "age": 22, "city": "Chicago"}', '{"name": "Bob", "age": 22, "city": "Chicago"}');
