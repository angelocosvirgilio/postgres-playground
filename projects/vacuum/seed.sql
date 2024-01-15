CREATE SCHEMA IF NOT EXISTS "vacuum";

CREATE TABLE vacuum.picture_likes (
    id bigserial NOT NULL,
    picture_id int8 NOT NULL,
    user_id int8 NOT NULL,
    CONSTRAINT picture_likes_pkey PRIMARY KEY (id)
);

