SELECT pg_stat_get_live_tuples(c.oid) AS n_live_tup , pg_stat_get_dead_tuples(c.oid) AS n_dead_tup
FROM   pg_class c where relname='picture_likes';