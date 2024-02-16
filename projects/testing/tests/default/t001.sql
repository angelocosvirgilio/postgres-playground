BEGIN;
SELECT plan(2);

SELECT has_table('testing'::name,'test_table'::name);

SELECT has_column('testing'::name,'test_table'::name, 'country', 'table test_table has to contain country column');

SELECT * FROM finish();
ROLLBACK;