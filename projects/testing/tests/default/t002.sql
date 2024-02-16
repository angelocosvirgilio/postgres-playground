BEGIN;
SELECT plan(3);

SELECT has_function(
    'testing',
    'insert_record',
    ARRAY ['VARCHAR(20)','DATE', 'VARCHAR(2)'],
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
  'angelo',
  '1982-11-30',
  'it');$$,
  $$SELECT id FROM "testing"."test_table" WHERE uname='angelo' AND date_of_birth='1982-11-30' AND country='it'$$,
  'It should return the id of the inserted record'
);


SELECT * FROM finish();
ROLLBACK;