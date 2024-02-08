/* 
  Cache big queries
*/
CREATE OR REPLACE FUNCTION pagila.get_rentals(p_year integer, p_limit integer)
RETURNS TABLE (rental_id integer, rental_date timestamp without time zone, movie_name text, customer_name text) AS $$
BEGIN
  RETURN QUERY SELECT r.rental_id, r.rental_date AT TIME ZONE 'UTC', f.title, CONCAT(c.first_name, ' ', c.last_name)
    FROM pagila.rental r
    JOIN pagila.inventory i ON r.inventory_id = i.inventory_id
    JOIN pagila.film f ON i.film_id = f.film_id
    JOIN pagila.customer c ON r.customer_id = c.customer_id
    WHERE date_part('year', r.rental_date) = p_year
    ORDER BY r.rental_id
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

/*
   Caching basic data validation
*/
CREATE OR REPLACE FUNCTION pagila.add_actor(p_first_name varchar, p_last_name varchar)
RETURNS SETOF pagila.actor AS $$
BEGIN
  -- check if actor already exists
  IF EXISTS (SELECT 1 FROM pagila.actor WHERE lower(first_name) = lower(p_first_name) AND lower(last_name) = lower(p_last_name)) THEN
    RAISE EXCEPTION 'Actor already exists';
  END IF;

  -- insert new actor record and return full record
  RETURN QUERY INSERT INTO pagila.actor (first_name, last_name)
  VALUES (p_first_name, p_last_name)
  RETURNING *;
END;
$$ LANGUAGE plpgsql;

/*
  Caching basic data validation / control pagination
*/
CREATE OR REPLACE FUNCTION pagila.get_rentals(cursor TIMESTAMP WITH TIME ZONE DEFAULT now())
RETURNS TABLE (
    rental_id INT,
    rental_date TIMESTAMP WITH TIME ZONE,
    inventory_id INT,
    customer_name VARCHAR(50),
    movie_title TEXT,
    staff_name VARCHAR(50),
    return_date TIMESTAMP WITH TIME ZONE,
    last_update TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
        SELECT rental.rental_id, rental.rental_date, rental.inventory_id,
            CONCAT(customer.first_name, ' ', customer.last_name)::VARCHAR(50) AS customer_name,
            film.title AS movie_title,
            CONCAT(staff.first_name, ' ', staff.last_name)::VARCHAR(50) AS staff_name,
            rental.return_date, rental.last_update
        FROM pagila.rental
        JOIN pagila.inventory ON rental.inventory_id = inventory.inventory_id
        JOIN pagila.customer ON rental.customer_id = customer.customer_id
        JOIN pagila.film ON inventory.film_id = film.film_id
        JOIN pagila.staff ON rental.staff_id = staff.staff_id
        WHERE rental.rental_date < cursor
        ORDER BY rental.rental_date DESC
        LIMIT 10;
END;
$$ LANGUAGE plpgsql;
