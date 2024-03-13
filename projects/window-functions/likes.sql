SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes,
  dense_rank() OVER (
    PARTITION BY post_id
    ORDER BY comments.created_at DESC
  ) AS comment_rank,
  sum(likes) OVER () total_likes
FROM windowf.posts LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id;


SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes,
  dense_rank() OVER (
    PARTITION BY post_id
    ORDER BY comments.created_at DESC
  ) AS comment_rank,
  sum(likes) OVER (PARTITION BY post_id) total_likes_per_post
FROM windowf.posts LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id;


SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes,
  dense_rank() OVER (
    PARTITION BY post_id
    ORDER BY comments.created_at ASC
  ) AS comment_rank,
  sum(likes) OVER (PARTITION BY post_id ORDER BY comments.created_at ASC) total_likes_until_this_post
FROM windowf.posts LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id;



SELECT posts.id AS post_id, comments.id AS comment_id, comments.body AS body, likes,
  dense_rank() OVER (
    PARTITION BY post_id
    ORDER BY comments.created_at ASC
  ) AS comment_rank,
  sum(likes) OVER w total_likes_per_post,
  avg(likes) OVER w avg_likes
FROM windowf.posts 
LEFT OUTER JOIN windowf.comments ON posts.id = comments.post_id
WINDOW w AS (PARTITION BY post_id);

