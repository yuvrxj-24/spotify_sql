-- Q12: Tracks with above-average liveness
SELECT track
FROM spotify
WHERE liveness > (
    SELECT AVG(liveness)
    FROM spotify
)
ORDER BY track;
