/*  
    We want the three most recent comments so we know we’ll need to do some sort of sorting by created_at and then limit the number of results.
*/
SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes,
  dense_rank() OVER (
    PARTITION BY post_id
    ORDER BY comments.created_at DESC
  ) AS comment_rank
FROM windowf.posts LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id;