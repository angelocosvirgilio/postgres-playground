CREATE SCHEMA IF NOT EXISTS "skip-locked";


CREATE TABLE "skip-locked".job_queue (
  id SERIAL PRIMARY KEY,
  task TEXT,
  status TEXT DEFAULT 'pending'
);


INSERT INTO "skip-locked".job_queue (task) 
SELECT 'task ' || i 
FROM generate_series(1, 10) i;


SELECT * FROM "skip-locked".job_queue;