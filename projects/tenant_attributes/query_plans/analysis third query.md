Certamente! Ecco l'analisi dettagliata dei risultati dei piani di query per la nuova query `SELECT * FROM "tenant_attr".t_tble WHERE tenant_id = 't_1' AND (tenant_attributes) @>'{"us", "Old city"}';` con i tre indici:

### Indice 1: `CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble(tenant_id, id);`

- **Piano di Query:**
  ```plaintext
  Gather  (cost=5216.93..17328.68 rows=463 width=55) (actual time=17.305..80.466 rows=444 loops=1)
     Workers Planned: 2
     Workers Launched: 2
     ->  Parallel Bitmap Heap Scan on t_tble  (cost=4216.93..16282.38 rows=193 width=55) (actual time=16.273..73.730 rows=148 loops=3)
           Recheck Cond: ((tenant_id = 't_1'::text) AND (id > 1000))
           Filter: (tenant_attributes @> '{us,"Old city"}'::text[])
           Rows Removed by Filter: 66447
           Heap Blocks: exact=3208
           ->  Bitmap Index Scan on ttble_idx  (cost=0.00..4216.82 rows=200839 width=0) (actual time=14.849..14.849 rows=199785 loops=1)
                 Index Cond: ((tenant_id = 't_1'::text) AND (id > 1000))
  Planning Time: 0.094 ms
  Execution Time: 80.541 ms
  ```

- **Analisi:**
  - **Tempo totale di esecuzione:** 80.541 ms
  - L'indice `ttble_idx` viene utilizzato per trovare i record con `tenant_id = 't_1'` e `id > 1000`.
  - Successivamente, viene applicato il filtro sui `tenant_attributes`.
  - Righe rimosse dal filtro: 66447.
  - La scansione dell'heap richiede una riconferma della condizione e un filtro aggiuntivo sui `tenant_attributes`.

### Indice 2: `CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble(tenant_id, tenant_attributes, id);`

- **Piano di Query:**
  ```plaintext
  Gather  (cost=1000.00..18945.27 rows=486 width=55) (actual time=0.418..73.686 rows=449 loops=1)
     Workers Planned: 2
     Workers Launched: 2
     ->  Parallel Seq Scan on t_tble  (cost=0.00..17896.67 rows=202 width=55) (actual time=0.929..63.532 rows=150 loops=3)
           Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
           Rows Removed by Filter: 333184
  Planning Time: 0.062 ms
  Execution Time: 73.728 ms
  ```

- **Analisi:**
  - **Tempo totale di esecuzione:** 73.728 ms
  - Utilizza una scansione sequenziale parallela con due worker.
  - Anche se utilizza più risorse, il tempo di esecuzione è leggermente migliore rispetto all'indice 1.
  - Righe rimosse dal filtro: 333184.
  - L'indice non sembra essere utilizzato in modo ottimale.

### Indice 3: `CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble(tenant_id, id, tenant_attributes);`

- **Piano di Query:**
  ```plaintext
  Gather  (cost=1000.00..18937.67 rows=480 width=55) (actual time=1.002..93.392 rows=431 loops=1)
     Workers Planned: 2
     Workers Launched: 2
     ->  Parallel Seq Scan on t_tble  (cost=0.00..17889.67 rows=200 width=55) (actual time=0.589..86.239 rows=144 loops=3)
           Filter: ((tenant_attributes @> '{us,"Old city"}'::text[]) AND (id > 1000) AND (tenant_id = 't_1'::text))
           Rows Removed by Filter: 333190
  Planning Time: 0.085 ms
  Execution Time: 93.447 ms
  ```

- **Analisi:**
  - **Tempo totale di esecuzione:** 93.447 ms
  - Utilizza una scansione sequenziale parallela con due worker.
  - Tempo di esecuzione peggiore rispetto agli altri due indici.
  - Righe rimosse dal filtro: 333190.
  - Anche questo indice non è utilizzato in modo ottimale.

### Conclusione
- **Indice 2** (`tenant_id, tenant_attributes, id`) offre le migliori prestazioni complessive per questa query specifica, con un tempo totale di esecuzione di 73.728 ms.
- Tuttavia, anche l'indice 1 (`tenant_id, id`) ha prestazioni comparabili, con un tempo di esecuzione di 80.541 ms.
- L'indice 3 (`tenant_id, id, tenant_attributes`) ha le peggiori prestazioni tra i tre, con un tempo di esecuzione di 93.447 ms.

In sintesi, per questa query specifica, l'indice più efficiente è il secondo (`CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble(tenant_id, tenant_attributes, id);`), seguito da vicino dal primo indice (`tenant_id, id`).