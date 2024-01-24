SELECT
  "id",
  (
  	DATE_TRUNC(
  	  'day',
  	  NOW() - INTERVAL '1d' * (
        floor(random() * (99 * 365 - 18 * 365 + 1) + 18 * 365)::int
      )
    )
  ) AS "bday"
FROM generate_series(1,10) "id";