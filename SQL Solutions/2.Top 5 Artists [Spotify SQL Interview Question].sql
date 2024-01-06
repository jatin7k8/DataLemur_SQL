with cte as(
SELECT 
a.artist_name,
 COUNT(s.song_id) as no_of_songs
FROM artists as a 
join songs as s 
on a.artist_id = s.artist_id
join global_song_rank as g   
on g.song_id = s.song_id

where g.rank <=10
GROUP BY  1
)

SELECT
artist_name,
artist_rank
FROM
(
SELECT
artist_name,
no_of_songs,
dense_rank() OVER(ORDER BY no_of_songs DESC) as artist_rank
FROM cte
) as t   
WHERE t.artist_rank <= 5
