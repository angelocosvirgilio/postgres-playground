-- session_b.sql
BEGIN;

-- Prova a prendere una riga libera saltando quelle lockate
SELECT * 
FROM "skip-locked".job_queue
WHERE status = 'pending'
FOR UPDATE SKIP LOCKED
LIMIT 1;

-- Simula elaborazione rapida
UPDATE "skip-locked".job_queue
SET status = 'processing'
WHERE id = (
  SELECT id 
  FROM "skip-locked".job_queue
  WHERE status = 'pending'
  FOR UPDATE SKIP LOCKED
  LIMIT 1
);

COMMIT;
