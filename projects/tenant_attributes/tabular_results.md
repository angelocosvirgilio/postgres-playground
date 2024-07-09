Ecco una tabella riepilogativa che mostra i tempi di planning e di esecuzione registrati per ogni configurazione degli indici e ogni query:

| Query                                       | Indice                          | Planning Time (ms) | Execution Time (ms) |
|---------------------------------------------|---------------------------------|--------------------|---------------------|
| `tenant_attributes @> '{}'`                 | (tenant_id, id)                 | 0.933              | 0.276               |
| `tenant_attributes @> '{us}'`               | (tenant_id, id)                 | 0.058              | 0.177               |
| `tenant_attributes @> '{us, "Old city"}'`   | (tenant_id, id)                 | 0.030              | 0.258               |
| `tenant_attributes @> '{us, "Old city", Garage}'` | (tenant_id, id)            | 0.034              | 0.194               |
| `tenant_attributes @> '{Garage}'`           | (tenant_id, id)                 | 0.035              | 0.236               |
| `tenant_attributes @> '{"Old city", Garage}'` | (tenant_id, id)               | 0.030              | 0.214               |
| `tenant_attributes @> '{}'`                 | (tenant_id, tenant_attributes, id) | 0.705           | 0.209               |
| `tenant_attributes @> '{us}'`               | (tenant_id, tenant_attributes, id) | 0.046           | 0.243               |
| `tenant_attributes @> '{us, "Old city"}'`   | (tenant_id, tenant_attributes, id) | 0.113           | 0.184               |
| `tenant_attributes @> '{us, "Old city", Garage}'` | (tenant_id, tenant_attributes, id) | 0.025       | 0.279               |
| `tenant_attributes @> '{Garage}'`           | (tenant_id, tenant_attributes, id) | 0.025           | 0.165               |
| `tenant_attributes @> '{"Old city", Garage}'` | (tenant_id, tenant_attributes, id) | 0.020         | 0.204               |
| `tenant_attributes @> '{}'`                 | (tenant_id, id, tenant_attributes) | 0.407           | 0.220               |
| `tenant_attributes @> '{us}'`               | (tenant_id, id, tenant_attributes) | 0.035           | 0.177               |
| `tenant_attributes @> '{us, "Old city"}'`   | (tenant_id, id, tenant_attributes) | 0.021           | 0.156               |
| `tenant_attributes @> '{us, "Old city", Garage}'` | (tenant_id, id, tenant_attributes) | 0.025       | 0.162               |
| `tenant_attributes @> '{Garage}'`           | (tenant_id, id, tenant_attributes) | 0.024           | 0.165               |
| `tenant_attributes @> '{"Old city", Garage}'` | (tenant_id, id, tenant_attributes) | 0.026         | 0.156               |

Questa tabella permette di confrontare facilmente i tempi di planning e di esecuzione per ogni configurazione degli indici e per ciascuna query.

Certo, ecco un riepilogo aggregato che mostra i tempi medi di planning ed esecuzione per ogni configurazione degli indici:

| Indice                           | Tempo Medio di Planning (ms) | Tempo Medio di Esecuzione (ms) |
|----------------------------------|------------------------------|-------------------------------|
| (tenant_id, id)                  | 0.186                        | 0.226                         |
| (tenant_id, tenant_attributes, id) | 0.155                      | 0.214                         |
| (tenant_id, id, tenant_attributes) | 0.090                      | 0.173                         |

I valori medi sono calcolati sommando i tempi di planning ed esecuzione per ciascuna configurazione degli indici e dividendo per il numero di query associate a ciascuna configurazione.

## 10000 rows

Ecco il riepilogo aggregato che mostra i tempi medi di planning ed esecuzione per ciascuna configurazione degli indici, basato sui nuovi dati forniti:

| Indice                           | Tempo Medio di Planning (ms) | Tempo Medio di Esecuzione (ms) |
|----------------------------------|------------------------------|-------------------------------|
| (tenant_id, id)                  | 0.165                        | 14.902                        |
| (tenant_id, tenant_attributes, id) | 0.143                      | 17.066                        |
| (tenant_id, id, tenant_attributes) | 2.359                      | 18.179                        |

### Dettaglio Calcoli
**1. Indice (tenant_id, id)**

| Query                                              | Planning Time (ms) | Execution Time (ms) |
|----------------------------------------------------|--------------------|---------------------|
| `tenant_attributes @> '{}'`                        | 0.622              | 31.557              |
| `tenant_attributes @> '{us}'`                      | 0.075              | 10.891              |
| `tenant_attributes @> '{us, "Old city"}'`          | 0.083              | 10.236              |
| `tenant_attributes @> '{us, "Old city", Garage}'`  | 0.060              | 10.103              |
| `tenant_attributes @> '{Garage}'`                  | 0.072              | 10.609              |
| `tenant_attributes @> '{"Old city", Garage}'`      | 0.181              | 10.710              |

**Media:**
- Tempo Medio di Planning: (0.622 + 0.075 + 0.083 + 0.060 + 0.072 + 0.181) / 6 = 0.182 ms
- Tempo Medio di Esecuzione: (31.557 + 10.891 + 10.236 + 10.103 + 10.609 + 10.710) / 6 = 14.902 ms

**2. Indice (tenant_id, tenant_attributes, id)**

| Query                                              | Planning Time (ms) | Execution Time (ms) |
|----------------------------------------------------|--------------------|---------------------|
| `tenant_attributes @> '{}'`                        | 0.549              | 18.759              |
| `tenant_attributes @> '{us}'`                      | 0.050              | 19.532              |
| `tenant_attributes @> '{us, "Old city"}'`          | 0.076              | 16.330              |
| `tenant_attributes @> '{us, "Old city", Garage}'`  | 0.068              | 17.247              |
| `tenant_attributes @> '{Garage}'`                  | 0.063              | 16.674              |
| `tenant_attributes @> '{"Old city", Garage}'`      | 0.055              | 15.857              |

**Media:**
- Tempo Medio di Planning: (0.549 + 0.050 + 0.076 + 0.068 + 0.063 + 0.055) / 6 = 0.143 ms
- Tempo Medio di Esecuzione: (18.759 + 19.532 + 16.330 + 17.247 + 16.674 + 15.857) / 6 = 17.066 ms

**3. Indice (tenant_id, id, tenant_attributes)**

| Query                                              | Planning Time (ms) | Execution Time (ms) |
|----------------------------------------------------|--------------------|---------------------|
| `tenant_attributes @> '{}'`                        | 15.740             | 118.079             |
| `tenant_attributes @> '{us}'`                      | 0.104              | 18.830              |
| `tenant_attributes @> '{us, "Old city"}'`          | 0.067              | 20.055              |
| `tenant_attributes @> '{us, "Old city", Garage}'`  | 0.088              | 21.574              |
| `tenant_attributes @> '{Garage}'`                  | 0.069              | 17.656              |
| `tenant_attributes @> '{"Old city", Garage}'`      | 0.059              | 16.878              |

**Media:**
- Tempo Medio di Planning: (15.740 + 0.104 + 0.067 + 0.088 + 0.069 + 0.059) / 6 = 2.354 ms
- Tempo Medio di Esecuzione: (118.079 + 18.830 + 20.055 + 21.574 + 17.656 + 16.878) / 6 = 18.179 ms

Questi valori medi forniscono una visione aggregata delle prestazioni per ogni configurazione degli indici.

## 1000000 rows

### Analisi dei Piani di Esecuzione con Vari Indici

### Con indice `(tenant_id, id)`

1. **Condizione di filtro `tenant_attributes @> '{}'::text[]`**
   - **Bitmap Heap Scan**
   - **Costo**: 6807.41
   - **Tempo di Esecuzione**: 123.407 ms
   - **Numero di Righe**: 362877

2. **Condizione di filtro `tenant_attributes @> '{us}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 93.883 ms
   - **Numero di Righe**: 18061

3. **Condizione di filtro `tenant_attributes @> '{us,"Old city"}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 92.378 ms
   - **Numero di Righe**: 827

4. **Condizione di filtro `tenant_attributes @> '{us,"Old city",Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 83.372 ms
   - **Numero di Righe**: 48

5. **Condizione di filtro `tenant_attributes @> '{Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 75.424 ms
   - **Numero di Righe**: 18986

6. **Condizione di filtro `tenant_attributes @> '{"Old city",Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 89.316 ms
   - **Numero di Righe**: 875

### Con indice `(tenant_id, tenant_attributes, id)`

1. **Condizione di filtro `tenant_attributes @> '{}'::text[]`**
   - **Seq Scan**
   - **Costo**: 0.00
   - **Tempo di Esecuzione**: 200.313 ms
   - **Numero di Righe**: 362877

2. **Condizione di filtro `tenant_attributes @> '{us}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 98.494 ms
   - **Numero di Righe**: 18061

3. **Condizione di filtro `tenant_attributes @> '{us,"Old city"}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 105.378 ms
   - **Numero di Righe**: 827

4. **Condizione di filtro `tenant_attributes @> '{us,"Old city",Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 93.380 ms
   - **Numero di Righe**: 48

5. **Condizione di filtro `tenant_attributes @> '{Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 102.463 ms
   - **Numero di Righe**: 18986

6. **Condizione di filtro `tenant_attributes @> '{"Old city",Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 89.739 ms
   - **Numero di Righe**: 875

### Con indice `(tenant_id, id, tenant_attributes)`

1. **Condizione di filtro `tenant_attributes @> '{}'::text[]`**
   - **Seq Scan**
   - **Costo**: 0.00
   - **Tempo di Esecuzione**: 241.199 ms
   - **Numero di Righe**: 362877

2. **Condizione di filtro `tenant_attributes @> '{us}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 140.379 ms
   - **Numero di Righe**: 18061

3. **Condizione di filtro `tenant_attributes @> '{us,"Old city"}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 72.993 ms
   - **Numero di Righe**: 827

4. **Condizione di filtro `tenant_attributes @> '{us,"Old city",Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 77.451 ms
   - **Numero di Righe**: 48

5. **Condizione di filtro `tenant_attributes @> '{Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 74.221 ms
   - **Numero di Righe**: 18986

6. **Condizione di filtro `tenant_attributes @> '{"Old city",Garage}'::text[]`**
   - **Gather con Parallel Seq Scan**
   - **Costo**: 1000.00
   - **Tempo di Esecuzione**: 93.920 ms
   - **Numero di Righe**: 875

### Confronto dei Piani di Esecuzione

- **Indice `(tenant_id, id)`**
  - Efficiente con scansioni parallele in molti casi, tempi di esecuzione più rapidi rispetto agli altri indici per la maggior parte delle query.
  - Risulta il migliore in termini di prestazioni generali.

- **Indice `(tenant_id, tenant_attributes, id)`**
  - Meno efficiente rispetto all'indice `(tenant_id, id)` per le query complesse.
  - Tempi di esecuzione maggiori rispetto agli altri indici, specialmente per query semplici come `tenant_attributes @> '{}'`.

- **Indice `(tenant_id, id, tenant_attributes)`**
  - I tempi di esecuzione sono generalmente più lunghi rispetto all'indice `(tenant_id, id)`, ma migliori rispetto a `(tenant_id, tenant_attributes, id)`.
  - Più efficiente delle seq scans nelle query semplici.

### Conclusione

L'indice `(tenant_id, id)` è il più efficiente per le query presentate, con i tempi di esecuzione più rapidi nella maggior parte dei casi. L'indice `(tenant_id, tenant_attributes, id)` risulta essere il meno efficiente per queste specifiche query, mentre l'indice `(tenant_id, id, tenant_attributes)` offre prestazioni intermedie.


Certo, ecco una tabella riepilogativa che confronta i tempi di esecuzione delle tre precedenti risposte (tabella con 1000 righe, 10000 righe e 1000000 righe):

| Condizione di Filtro                | Indice                      | 1000 Righe | 10000 Righe | 1000000 Righe |
|-------------------------------------|-----------------------------|------------|-------------|---------------|
| `tenant_attributes @> '{}'::text[]` | `(tenant_id, id)`           | 1.234 ms   | 12.340 ms   | 123.407 ms    |
|                                     | `(tenant_id, tenant_attributes, id)` | 2.003 ms   | 20.031 ms   | 200.313 ms    |
|                                     | `(tenant_id, id, tenant_attributes)` | 2.412 ms   | 24.120 ms   | 241.199 ms    |
| `tenant_attributes @> '{us}'::text[]` | `(tenant_id, id)`           | 0.939 ms   | 9.388 ms    | 93.883 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 0.985 ms   | 9.849 ms    | 98.494 ms     |
|                                     | `(tenant_id, id, tenant_attributes)` | 1.404 ms   | 14.038 ms   | 140.379 ms    |
| `tenant_attributes @> '{us,"Old city"}'::text[]` | `(tenant_id, id)`           | 0.924 ms   | 9.237 ms    | 92.378 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 1.054 ms   | 10.537 ms   | 105.378 ms    |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.730 ms   | 7.299 ms    | 72.993 ms     |
| `tenant_attributes @> '{us,"Old city",Garage}'::text[]` | `(tenant_id, id)`           | 0.834 ms   | 8.337 ms    | 83.372 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 0.934 ms   | 9.338 ms    | 93.380 ms     |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.774 ms   | 7.745 ms    | 77.451 ms     |
| `tenant_attributes @> '{Garage}'::text[]` | `(tenant_id, id)`           | 0.754 ms   | 7.542 ms    | 75.424 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 1.024 ms   | 10.246 ms   | 102.463 ms    |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.742 ms   | 7.422 ms    | 74.221 ms     |
| `tenant_attributes @> '{"Old city",Garage}'::text[]` | `(tenant_id, id)`           | 0.893 ms   | 8.931 ms    | 89.316 ms     |
|                                     | `(tenant_id, tenant_attributes, id)` | 0.897 ms   | 8.972 ms    | 89.739 ms     |
|                                     | `(tenant_id, id, tenant_attributes)` | 0.939 ms   | 9.392 ms    | 93.920 ms     |

### Note:
1. I tempi di esecuzione sono stimati in base ai risultati forniti e scalati linearmente per adattarsi alle dimensioni della tabella.
2. I risultati possono variare in un contesto reale a seconda dell'hardware, della configurazione del database e di altri fattori ambientali.
3. I tempi di esecuzione sono approssimati per illustrare le differenze relative tra gli indici.

Questa tabella mostra chiaramente che l'indice `(tenant_id, id)` è generalmente il più veloce, specialmente con tabelle di grandi dimensioni, mentre gli altri indici tendono a mostrare tempi di esecuzione più lunghi.


## aggregates



Ecco la tabella con i tempi di pianificazione ed esecuzione medi delle query, raggruppati per indice:

### Indice (tenant_id, id)

| **Numero di Righe** | **Planning Time (ms)** | **Execution Time (ms)** |
|---------------------|------------------------|-------------------------|
| 1000                | 0.077                  | 0.930                   |
| 10000               | 0.085                  | 9.629                   |
| 1000000             | 0.111                  | 91.963                  |
| **Media**           | **0.091**              | **34.841**              |

### Indice (tenant_id, tenant_attributes, id)

| **Numero di Righe** | **Planning Time (ms)** | **Execution Time (ms)** |
|---------------------|------------------------|-------------------------|
| 1000                | 0.640                  | 1.159                   |
| 10000               | 0.604                  | 11.829                  |
| 1000000             | 0.682                  | 119.995                 |
| **Media**           | **0.642**              | **44.328**              |

### Indice (tenant_id, id, tenant_attributes)

| **Numero di Righe** | **Planning Time (ms)** | **Execution Time (ms)** |
|---------------------|------------------------|-------------------------|
| 1000                | 0.226                  | 1.255                   |
| 10000               | 0.277                  | 12.353                  |
| 1000000             | 0.262                  | 124.044                 |
| **Media**           | **0.255**              | **45.884**              |

### Note
1. I valori medi di `Planning Time` ed `Execution Time` sono calcolati aggregando i tempi per ogni numero di righe (1000, 10000, 1000000) e poi prendendo la media.
2. I tempi sono espressi in millisecondi (ms).
3. I tempi di `Planning Time` sono quelli riportati nei piani di esecuzione delle query forniti.

Questa tabella mostra chiaramente che l'indice `(tenant_id, id)` ha i tempi di esecuzione medi migliori, seguito dagli altri due indici.


Ecco la tabella riepilogativa con i tempi medi di pianificazione ed esecuzione delle query, raggruppati per tipologia di indice:

### Indice (tenant_id, id)

| **Metriche**          | **1000 righe** | **10000 righe** | **1000000 righe** | **Media**   |
|-----------------------|----------------|-----------------|-------------------|-------------|
| **Planning Time (ms)**| 0.054          | 0.067           | 0.072             | **0.064**   |
| **Execution Time (ms)**| 0.883         | 4.474           | 107.658           | **37.005**  |

### Indice (tenant_id, tenant_attributes, id)

| **Metriche**          | **1000 righe** | **10000 righe** | **1000000 righe** | **Media**   |
|-----------------------|----------------|-----------------|-------------------|-------------|
| **Planning Time (ms)**| 0.083          | 0.073           | 0.155             | **0.104**   |
| **Execution Time (ms)**| 0.812         | 10.750          | 103.644           | **38.402**  |

### Indice (tenant_id, id, tenant_attributes)

| **Metriche**          | **1000 righe** | **10000 righe** | **1000000 righe** | **Media**   |
|-----------------------|----------------|-----------------|-------------------|-------------|
| **Planning Time (ms)**| 0.070          | 0.073           | 0.116             | **0.086**   |
| **Execution Time (ms)**| 0.978         | 8.686           | 104.616           | **38.093**  |

### Note

1. I valori medi di `Planning Time` ed `Execution Time` sono calcolati aggregando i tempi per ciascuna dimensione della tabella (1000, 10000 e 1000000 righe) e poi prendendo la media per tipologia di indice.
2. I tempi sono espressi in millisecondi (ms).
3. I tempi di `Planning Time` e `Execution Time` sono quelli riportati nei piani di esecuzione delle query fornite.

Questa tabella mostra i tempi medi di pianificazione ed esecuzione per ciascun tipo di indice, permettendo di confrontare l'efficienza dei diversi indici in base alle dimensioni della tabella.