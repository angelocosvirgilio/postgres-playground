/*
Let's say that we want to compose a few fields out of the user's age:

username + year of birth as in "Luke_99"
year of birth
current age
That is not really achievable within one single query, but the WITH statement comes in handy here as we can prepare statements and use them in subsequent queries:
*/

WITH
  -- Generate a list of random numbers from 1 to 50:
  "randomic_data" AS (
    SELECT floor(random() * 50 + 1)AS "rand"
    FROM generate_series(1,10) "id"
  )

  -- Use the row-by-row randomic number to compose
  -- realistic user information:
, "user_data" AS (
    SELECT
      -- randomic username
        (
          CONCAT(
            'user_',
            TO_CHAR(NOW() - INTERVAL '1y' * "rand" ,'YY')
          )
        ) AS "uname"

      -- randomic year of birth
            -- tricky version :P
            /*, DATE_TRUNC(
                'day',
                NOW() - INTERVAL '1d' * (
                floor(random() * ((
                    ("rand" + 1) * 365
                ) - (
                    "rand" * 365
                ) + 1) + (
                    "rand" * 365
                ))::int
                )
            ) AS "bday"
            */

      -- can be simplified in 
      , DATE_TRUNC(
        'day',
        NOW() - INTERVAL '1d' * (
          floor(random() * (365 + 1) + ("rand" * 365))::int
        )
      ) AS "bday"



      -- Also provide the simple age:
    , "rand" AS "age"

    -- Source values from the randomic list
    FROM "randomic_data"
  )

-- Eventually, use the generated dataset to populate a table
--INSERT INTO "users" ("uname", "bday", "age")
SELECT * FROM "user_data"

-- NOTE: randomic values can easily generate duplicates!
--ON CONFLICT ON CONSTRAINT "users_uname_key" DO NOTHING
--RETURNING *;
