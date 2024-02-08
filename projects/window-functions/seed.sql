CREATE SCHEMA IF NOT EXISTS "windowf";

CREATE TABLE windowf.posts (
  id integer PRIMARY KEY,
  body varchar,
  created_at timestamp DEFAULT current_timestamp
);

CREATE TABLE windowf.comments (
 id INTEGER PRIMARY KEY,
 post_id integer NOT NULL,
 body varchar,
 likes int,
 created_at timestamp DEFAULT current_timestamp
);

/* make two posts */
INSERT INTO windowf.posts VALUES (1, 'foo');
INSERT INTO windowf.posts VALUES (2, 'bar');

/* make 4 comments for the first post */
INSERT INTO windowf.comments VALUES (1, 1, 'foo old', 3);
INSERT INTO windowf.comments VALUES (2, 1, 'foo new', 24);
INSERT INTO windowf.comments VALUES (3, 1, 'foo newer', 0);
INSERT INTO windowf.comments VALUES (4, 1, 'foo newest', 100);

/* make 4 comments for the second post */
INSERT INTO windowf.comments VALUES (5, 2, 'bar old', 100);
INSERT INTO windowf.comments VALUES (6, 2, 'bar new', 26);
INSERT INTO windowf.comments VALUES (7, 2, 'bar newer', 44);
INSERT INTO windowf.comments VALUES (8, 2, 'bar newest', 5);