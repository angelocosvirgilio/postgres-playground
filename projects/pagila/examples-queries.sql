-- Cache big queries
--SELECT * FROM pagila.get_rentals(2022, 10);

-- Caching basic data validation
--SELECT * FROM pagila. add_actor('John', 'Doe');

-- Caching basic data validation / control pagination
SELECT * FROM pagila.get_rentals();
SELECT * FROM pagila.get_rentals('2022-07-23 21:19:33+00');
