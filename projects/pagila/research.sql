-- SELECT * FROM pagila.film WHERE fulltext @@ to_tsquery('fate&india');


-- SELECT title, description
-- FROM pagila.film
-- WHERE to_tsvector('english', description) @@ to_tsquery('english', 'drama & composer')
-- LIMIT 10;

SELECT title, description, ts_rank(to_tsvector('english', description), to_tsquery('english', 'drama & composer')) AS rank
FROM pagila.film
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'drama & composer')
ORDER BY rank DESC
LIMIT 10;