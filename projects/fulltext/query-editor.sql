SELECT to_tsvector('italian', 'Sempre caro mi fu quest’ermo colle,
e questa siepe, che da tanta parte
dell’ultimo orizzonte il guardo esclude.'),  -- create the column with the lexims in a certain dictionary

to_tsvector('italian', 'Sempre caro mi fu quest’ermo colle,
e questa siepe, che da tanta parte
dell’ultimo orizzonte il guardo esclude.')
@@ to_tsquery('italian', 'esclude & tanto');  -- @@ to_tsquery try to match in a certain dictionary the words "esclude" and "tanto" -> return true if matches otherwise false


-- ranking results https://www.postgresql.org/docs/current/textsearch-controls.html#TEXTSEARCH-RANKING


-- ts headline https://www.postgresql.org/docs/current/textsearch-controls.html#TEXTSEARCH-HEADLINE
SELECT ts_headline('english',
  'The most common type of search
is to find all documents containing given query terms
and return them in order of their similarity to the
query.',
  to_tsquery('english', 'query & similarity'));


SELECT ts_headline('english',
  'Search terms may occur
many times in a document,
requiring ranking of the search matches to decide which
occurrences to display in the result.',
  to_tsquery('english', 'search & term'),
  'MaxFragments=10, MaxWords=7, MinWords=3, StartSel=<<, StopSel=>>');