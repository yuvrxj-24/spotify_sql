# 🎵 Spotify SQL Data Analysis

## 📌 Project Overview
This project explores a Spotify dataset using SQL to uncover insights related to
streaming behavior, artist performance, track popularity, and audio features.

The analysis demonstrates practical SQL skills including:
- Data cleaning
- Aggregations & grouping
- Subqueries
- Common Table Expressions (CTEs)
- Window functions

---

## 🛠 Tech Stack
- SQL (PostgreSQL compatible)
- Relational Data Analysis

---

## 📊 Key Analysis Performed
✔ Tracks with over 1 billion streams  
✔ Artist-wise track count analysis  
✔ Album-level view aggregation  
✔ Platform comparison (Spotify vs YouTube)  
✔ Top tracks per artist using window functions  
✔ Feature-based analysis (energy, liveness, danceability)

---

## 🧠 Sample Query
```sql
WITH ranking_artist AS (
    SELECT 
        artist,
        track,
        SUM(views) AS total_views,
        DENSE_RANK() OVER (
            PARTITION BY artist 
            ORDER BY SUM(views) DESC
        ) AS rank
    FROM spotify
    GROUP BY artist, track
)
SELECT *
FROM ranking_artist
WHERE rank <= 3;
