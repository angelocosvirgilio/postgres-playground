/*  
    we need to fetch just those comments that have a comment_rank less than 4 (since we want only the three most recent comments). 
    We can achieve this goal by using our new ranking query as a sub-select statement like so:
*/
SELECT comment_id, post_id, body FROM (
  SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes,
    dense_rank() OVER (
      PARTITION BY post_id
      ORDER BY comments.created_at DESC
    ) AS comment_rank
  FROM windowf.posts LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id
) AS ranked_comments
WHERE comment_rank < 4;