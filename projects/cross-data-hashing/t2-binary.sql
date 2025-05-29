DROP TABLE IF EXISTS "cross-data-hash".products;

CREATE TABLE "cross-data-hash".products (
  id SERIAL PRIMARY KEY,
  prod_id BYTEA,
  code VARCHAR(20),
  price NUMERIC
);

INSERT INTO "cross-data-hash".products (prod_id, code, price)
VALUES
('prodA1', 'Product A1', 19.99),
('prodB2', 'Product B2', 29.50),
('prodC3', 'Product C3', 15.75),
('prodD4', 'Product D4', 42.00),
('prodE5', 'Product E5', 8.99),
('prodF6', 'Product F6', 23.45),
('prodG7', 'Product G7', 17.80),
('prodH8', 'Product H8', 31.25),
('prodI9', 'Product I9', 27.60),
('prodJ10','Product J10',12.30);


SELECT prod_id, code, price
FROM "cross-data-hash".products
where prod_id IN ('prodE5', 'prodI9');

EXPLAIN ANALYZE
SELECT prod_id, code, price
FROM "cross-data-hash".products
where prod_id IN ('prodE5', 'prodI9');
