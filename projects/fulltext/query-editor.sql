SELECT to_tsvector('italian', 'Sempre caro mi fu quest’ermo colle,
e questa siepe, che da tanta parte
dell’ultimo orizzonte il guardo esclude.'),  -- create the column with the lexims in a certain dictionary

to_tsvector('italian', 'Sempre caro mi fu quest’ermo colle,
e questa siepe, che da tanta parte
dell’ultimo orizzonte il guardo esclude.')
@@ to_tsquery('italian', 'esclude & tanto');  -- @@ to_tsquery try to match in a certain dictionary the words "esclude" and "tanto" -> return true if matches otherwise false