-- session_a.sql
BEGIN;

-- Locka una riga con FOR UPDATE
SELECT * 
FROM "skip-locked".job_queue
WHERE status = 'pending'
FOR UPDATE SKIP LOCKED
LIMIT 1;

-- Simula un'elaborazione lunga (es: 60 secondi)
SELECT pg_sleep(60);

-- Cambia stato del task
UPDATE "skip-locked".job_queue 
SET status = 'processing'
WHERE status = 'pending'
AND id = (
  SELECT id 
  FROM "skip-locked".job_queue
  WHERE status = 'pending'
  LIMIT 1
);

COMMIT;
