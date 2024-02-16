BEGIN;
SELECT plan(5);

SELECT has_function(
    'testing',
    'insert_record',
    ARRAY ['INT', 'VARCHAR(20)','DATE', 'VARCHAR(2)'],
    'It should confirm that insert_record function exists'
);

SELECT function_returns(
    'testing',
    'insert_record',
    'INT',
    'It should confirm that insert_record function returns an INT'
);

SELECT results_eq(
  $$SELECT *
    FROM "testing"."insert_record"(
  1,
  'tizio',
  '1990-01-20',
  'it');$$,
  $$VALUES 
    (1)
  $$,
  'It should return id=2'
);

-- It should get an error if record already exists
SELECT throws_ok(
  $$SELECT *
    FROM "testing"."insert_record"(
  2,
  'tizio',
  '1990-01-20',
  'it');$$
);

-- It should get an error for primary key duplication
SELECT throws_ok(
  $$SELECT *
    FROM "testing"."insert_record"(
  1,
  'caio',
  '1994-05-18',
  'es');$$
);

SELECT * FROM finish();
ROLLBACK;