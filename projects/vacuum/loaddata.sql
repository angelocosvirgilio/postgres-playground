do $$
begin
for r in 1..3 loop
    WITH users AS (
      SELECT *
      FROM generate_series(1, 1000000)
    )
    INSERT INTO vacuum.picture_likes
    (picture_id, user_id)
    SELECT r, generate_series FROM users;
end loop;
end;
$$;