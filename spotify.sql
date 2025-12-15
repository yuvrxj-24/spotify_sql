DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

select * from spotify limit 5;

delete from spotify
where duration_min = 0;

select * from spotify 
where duration_min=0;

-- Q1 Retrieve the names of all tracks that have more than 1 Billion streams.

Select * from spotify
where stream > 1000000000

-- Q2 List all albums along with their respective artists. 

select Distinct (album,artist )
from spotify
order by 1 

-- Q3 Get the total number of comments for tracks where licensed = TRUE.

Select COUNT (comments) 
from spotify
Where licensed = 'true'

--sum of comments in order to get total comments. 

select sum(comments) as total_comments
from spotify 
where licensed = 'true' 

-- Q4 Find all tracks that belong to the album type single
select track 
from spotify 
where album_type = 'single'
order by track

-- Q5 Count the total number of tracks by each artist. 
select artist,count(track) as nos_track
from spotify 
group by artist
order by 2

--Q6 Calculate the average danceability of tracks in each album 

select album, avg (danceability) as avg_dance
from spotify 
group by album
order by 2 desc

-- Q7 Find the top 5 tracks with the highest energy values  

select track, max(energy) 
from spotify 
group by 1
order by 2 desc 
limit 5 

-- Q8 List all tracks along with their views and likes where official_video = true 

select track, sum(likes) as tot_l, sum(views) as tot_v from spotify
where official_video = 'true'
group by track 

order by track desc 

-- Q9 For each album , calculate the total views of all associated tracks 

select album,track, sum(views) as tot_v 
from spotify
group by album,track 
order by tot_v desc

-- Q10 Retrieve the track names that have been streamed on spotify more than youtube
SELECT *
FROM (
    SELECT 
        track,
        COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END), 0) AS streamed_on_yt,
        COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END), 0) AS streamed_on_sp
    FROM spotify
    GROUP BY track
) AS q1
WHERE streamed_on_sp > streamed_on_yt
and streamed_on_yt <>0


-- Q11 Find the top 3 most-viewed tracks for each artist using window functions.

with ranking_artist 
as
(select 
	artist,
	track,
	SUM (views) as tot_view,
	dense_rank() over(partition by artist order by sum(views) desc ) as rnk
from spotify 
group by 1,2
order by 1,3 desc 

)
select * from ranking_artist
where rnk <=3


-- Q12 Write a query to find tracks where the liveness score is above the average.

SELECT track
FROM spotify
WHERE liveness > (
    SELECT AVG(liveness)
    FROM spotify
)
ORDER BY track;

-- Q13 Use a With clause to calculate the difference between the highest and the lowest energy values for tracks in each album. 

with cte 
as 
(select 
	album,
	max(energy) as highest_en,
	min(energy) as lowest_en

from spotify 
group by 1 
)
select 
	album,
	highest_en - lowest_en as en_diff
from cte