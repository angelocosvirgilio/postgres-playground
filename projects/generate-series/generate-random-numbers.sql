-- Let's say we want to add an age field, and age should be in the 18-99 range:
SELECT
  "id",
  floor(random() * (99 - 18 + 1) + 18)::int AS "age"
FROM generate_series(1,10) "id";