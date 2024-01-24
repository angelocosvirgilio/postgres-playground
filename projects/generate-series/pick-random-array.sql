SELECT
  "id",
  (
    SELECT (array['it', 'us', 'fr', 'se', 'no'])[floor(random() * 5 + 1)]
    WHERE "id" = "id"
  ) as "country"
FROM generate_series(1,10) "id";