-- creating table schema
CREATE TABLE case_study (
original_title VARCHAR NOT NULL,
url VARCHAR NOT NULL,
locale VARCHAR NOT NULL,
article_ID VARCHAR NOT NULL,
published_date DATE NOT NULL,
vertical VARCHAR NOT NULL,
traffic_channel VARCHAR NOT NULL,
page_views INT NOT NULL
);
-- copying data into schema 
\copy public.case_study (original_title, url, locale, article_id, published_date, vertical, traffic_channel, page_views) FROM '/Users/sathwikkes/Desktop/CASE_STUDY_DATA.csv' CSV DELIMITER ',' HEADER;
-- QUOTE '"' ESCAPE ''''
-- checking out our data
SELECT * from case_study;
SELECT COUNT(*) from case_study;

-- Part 1 
-- https://stackoverflow.com/questions/30643949/how-to-get-a-id-from-a-url-using-sql-query-the-id-changes-dynamically-the-data
-- this returns the article_id 
-- q1
SELECT SUBSTRING(url, POSITION('icle/' in url) + 5, 6)
FROM case_study;

-- q2
-- extract day of week, week # respective to year
-- EXTRACT('doy' FROM published_date) as "day of year"
SELECT
EXTRACT('dow' FROM published_date) as "day of week",
EXTRACT('week' FROM published_date) as "week number"
FROM case_study; 
-- unique daily output, 87 days in total
SELECT published_date,  
COUNT(DISTINCT article_id)
FROM case_study
GROUP BY published_date; 
-- unique weekly output, 14 weeks
SELECT 
COUNT(DISTINCT article_id), 
EXTRACT('week' FROM published_date) as "week number"
FROM case_study
GROUP BY 2
ORDER BY 1 DESC;
-- The day of week Sunday (0) to Saturday (6)
-- article trend throughout week
SELECT 
COUNT(DISTINCT article_id),
EXTRACT('dow' FROM published_date) as "day of week"
FROM case_study
GROUP BY 2;

--Q3
SELECT 
COUNT(DISTINCT article_id) as "total articles", 
SUM(page_views) as "total traffic",
vertical
FROM case_study
GROUP BY 3;
--Q4 
CREATE TABLE vice_data(
	sector VARCHAR NOT NULL, 
	content_ouput VARCHAR NOT NULL, 
    traffic_contribution VARCHAR NOT NULL, 
	total_output INT NOT NULL, 
)


-- Miscelleanous
SELECT MIN(published_date)
FROM case_study;
-- 05/01/21

SELECT MAX(published_date)
FROM case_study;
-- 07/31/21
-- 92 days/13 weeks time frame (including end date) 
-- however in total we only have 87 days worth of data, missing 5 days
SELECT COUNT(DISTINCT published_date)
FROM case_study;

SELECT LENGTH(article_id)
FROM case_study;

