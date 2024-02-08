/*  
   We can gain back some of the readability by using a Common Table Expression (or CTE). Our query would become:
*/
WITH ranked_comments AS (
  SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes, 
    dense_rank() OVER (
      PARTITION BY post_id
      ORDER BY comments.created_at DESC
    ) AS comment_rank
  FROM windowf.posts LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id
)

SELECT
  post_id,
  comment_id,
  body,
  likes
FROM ranked_comments
WHERE comment_rank < 4;