-- Deliverables
-- In order to answer the key business questions, you will follow the steps of the data analysis process: **ask, prepare, process, analyze, share, and act**.


-- **Ask**

/*
 
 Three questions will guide the future marketing program:
 1. How do annual members and casual riders use Cyclistic bikes differently?
 2. Why would casual riders buy Cyclistic annual memberships?
 3. How can Cyclistic use digital media to influence casual riders to become members?


Tasks:

 1. Identify the business task: The ultimate business goal is to increase the amount of casual riders.
    The business task is to analyze previous user data to understand the key preferences and differences between casual riders and members.
    Then, improve the future marketing strategies and programs based on the findings.
    
 2. Consider key stakeholders:
 ● Lily Moreno:
   The director of marketing and your manager. 
   Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program.
   These may include email, social media, and other channels.
 ● Cyclistic marketing analytics team: 
   A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
   You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals — as well as how you,
   as a junior data analyst, can help Cyclistic achieve them.
 ● Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.

*/


-- **Prepare**

/*

Tasks:

1. Download data and store it appropriately:
    I downloaded the data in CSV. for the whole year of 2022 to analyze the behavior of casual riders and members,
    and find insights for 2023 marketing strategy. 
    I uploaded the data to BigQuery.
    
    The database name: `practice-gda-377022`
    The dataset name: `cyclistic`
    Table names: 202201, 202202, 202203 ... 202212, a total of 12 tables.
    
2. Identify how it’s organized:
    The data is categorized by month, and the data structure is the same for each month.
    
3. Sort and filter the data: I imported the 12 CSV files in Excel and sorted them ascendingly to find if there was any NULL value.

4. Determine the credibility of the data: The data is creditable because it is from the company's database (according to the scenario.)

*/


-- **Process**

/*

Tasks:

1. Check the data for errors.

2. Choose your tools: I will use Excel and SQL(BigQuery) to clean data and then use SQL(BigQuery) to analyze.

3. Transform the data so you can work with it effectively.

4. Document the cleaning process:

-- Exploration and data cleaning

SELECT
 column_name,
 COUNT(table_name) num_table
FROM
 `practice-gda-377022.cyclistic.INFORMATION_SCHEMA.COLUMNS`
GROUP BY
 1;
 
 -- Result:

    column_name   |num_table|
------------------+---------+
ride_id           |       12| 
rideable_type     |       12|
started_at        |       12|
ended_at          |       12|
start_station_name|       12|
end_station_name  |       12|
start_station_id  |       12|
end_station_id    |       12|
start_station_name|       12|
end_station_name  |       12|
start_lat         |       12|
start_lng         |       12|
end_lat           |       12|
end_lng           |       12|
member_casual     |       12|
   
 -- Now I know the column names are consistent among the 12 tables.
 
 

-- Combine the 12 table together for further analysis
SELECT *
FROM  `practice-gda-377022.cyclistic.202201`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202202`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202203`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202204`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202205`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202206`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202207`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202208`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202209`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202210`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202211`
UNION ALL
SELECT *
FROM `practice-gda-377022.cyclistic.202212`;

-- Saved as '2022'.



-- Check and delete negative time

SELECT
  COUNT(ride_id) neg_time
FROM `practice-gda-377022.cyclistic.2022`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 0;

-- Result:
neg_time|
--------+
      74|

-- There are 74 rows that have negative time, which means the ended time was earlier than the started time.

DELETE FROM `practice-gda-377022.cyclistic.2022`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 0;
-- Delete the negative time rows.



-- Explore the data: total (unique) number of ride_id, mean, maximum, and minimum.

SELECT
  COUNT(ride_id) total_id,
  COUNT(DISTINCT ride_id) unique_id
FROM `practice-gda-377022.cyclistic.2022`;

-- Result:
total_id|unique_id|
--------+----------
 5667643| 5667643

-- The total number of ride_id is 5,667,643, and they are all unique, so there's no need for deleting duplicate rows.



-- Explore statistics for each month

-- January 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-01-01' AND started_at < '2022-02-01';

--Result

total_trip|max_duration|min_duration|     avg_duration     |
----------+------------+------------+-----------------------
    103770|         487|           0|0-0 0 0:15:15.879840030 


-- The total trip in January 2022 was 103,770, the most duration was 487 hours, the least duration was 0,
-- and the average duration was around 00:15:15.


-- February 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-02-01' AND started_at < '2022-03-01';
-- The total trip in February 2022 was 115,609, the most duration was 181 hours, the least duration was 0,
-- and the average duration was around 00:14:14.

--March 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-03-01' AND started_at < '2022-04-01';
-- The total trip in March 2022 was 284,041, the most duration was 572 hours, the least duration was 0,
-- and the average duration was around 00:18:29.

--April 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-04-01' AND started_at < '2022-05-01';
-- The total trip in April 2022 was 371,249, the most duration was 352 hours, the least duration was 0,
-- and the average duration was around 00:17:38.

--May 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-05-01' AND started_at < '2022-06-01';
-- The total trip in May 2022 was 634,858, the most duration was 604 hours, the least duration was 0,
-- and the average duration was around 00:21:6.

--June 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-06-01' AND started_at < '2022-07-01';
-- The total trip in June 2022 was 769,193, the most duration was 597 hours, the least duration was 0,
-- and the average duration was around 00:22:41.

--July 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-07-01' AND started_at < '2022-08-01';
-- The total trip in July 2022 was 823,475, the most duration was 570 hours, the least duration was 0,
-- and the average duration was around 00:21:23.

--August 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-08-01' AND started_at < '2022-09-01';
-- The total trip in August 2022 was 785,925, the most duration was 468 hours, the least duration was 0,
-- and the average duration was around 00:20:39.

--September 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-09-01' AND started_at < '2022-10-01';
-- The total trip in September 2022 was 701,336, the most duration was 461 hours, the least duration was 0,
-- and the average duration was around 00:19:20.

--October 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-10-01' AND started_at < '2022-11-01';
-- The total trip in October 2022 was 558,684, the most duration was 689 hours, the least duration was 0,
-- and the average duration was around 00:17:21.

--November 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-11-01' AND started_at < '2022-12-01';
-- The total trip in November 2022 was 337,697, the most duration was 326 hours, the least duration was 0,
-- and the average duration was around 00:14:10.

--December 2022
SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-12-01' AND started_at <= '2022-12-31';
-- The total trip in December 2022 was 176,753, the most duration was 319 hours, the least duration was 0,
-- and the average duration was around 00:13:25.

-- Union all statistics for further analysis
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-01-01' AND started_at < '2022-02-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-02-01' AND started_at < '2022-03-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-03-01' AND started_at < '2022-04-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-04-01' AND started_at < '2022-05-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-05-01' AND started_at < '2022-06-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-06-01' AND started_at < '2022-07-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-07-01' AND started_at < '2022-08-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-08-01' AND started_at < '2022-09-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-09-01' AND started_at < '2022-10-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-10-01' AND started_at <= '2022-11-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-11-01' AND started_at < '2022-12-01'
GROUP BY month
UNION ALL
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-12-01' AND started_at <= '2022-12-31'
GROUP BY month
ORDER BY month;
-- Saved as '2022statistics'

-- Mean duration each ride_id
SELECT 
  ride_id,
  AVG(ended_at-started_at) AS duration
FROM (
  SELECT
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202201`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202202`
  UNION ALL
  SELECT 
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202203`
  UNION ALL
  SELECT 
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202204`
  UNION ALL
  SELECT 
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202205`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at 
  FROM `practice-gda-377022.cyclistic.202206`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at 
  FROM `practice-gda-377022.cyclistic.202207`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202208`
  UNION ALL
  SELECT 
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202209`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at 
  FROM `practice-gda-377022.cyclistic.202210`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at
  FROM `practice-gda-377022.cyclistic.202211`
  UNION ALL
  SELECT
    ride_id,
    ended_at,
    started_at 
  FROM `practice-gda-377022.cyclistic.202212`
)
GROUP BY ride_id
ORDER BY duration DESC;

-- Create a table for further analysis with weekday, and extract day, month, start hour, and minute duration.
SELECT 
  ride_id,
  DATE(started_at) AS day,
  FORMAT_DATE('%B', DATE(started_at)) AS month,
  FORMAT_DATE('%A', DATE(started_at)) AS weekday,
  FORMAT_TIME('%k', TIME(started_at)) AS start_hour,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS duration_minute,
  member_casual
FROM `practice-gda-377022.cyclistic.2022`
ORDER BY day, ride_id;
-- Saved as '2022weekday'

