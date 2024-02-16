BEGIN;

-- Assert function returns expected value
SELECT plan(2);
SELECT ok(1 + 1 = 2, '1 + 1 equals 2');
SELECT ok(2 < 3, '2 is less than 3');

ROLLBACK;