-- Process

/*

Tasks:

1. Check the data for errors.

2. Choose your tools: I will use Excel and SQL(BigQuery) to clean data and then use SQL(BigQuery) to analyze.

3. Transform the data so you can work with it effectively.

4. Document the cleaning process:

*/

-- Exploration and data cleaning

SELECT
 column_name,
 COUNT(table_name) num_table
FROM
 `practice-gda-377022.cyclistic.INFORMATION_SCHEMA.COLUMNS`
GROUP BY
 1;
 
 -- Result:

column_name       |num_table|
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
WHERE
 TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 0
 OR TIMESTAMP_DIFF(ended_at, started_at, SECOND) < 0;

-- Result:

neg_time|
--------+
100     |

-- There are 100 rows that have negative time, which means the ended time was earlier than the started time.

DELETE FROM `practice-gda-377022.cyclistic.2022`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 0;

DELETE FROM `practice-gda-377022.cyclistic.2022`
WHERE TIMESTAMP_DIFF(ended_at, started_at, SECOND) < 0;

-- Delete the negative time rows.



-- Explore the data: the total and unique number of ride_id, and the mean, maximum, and minimum time duration for 2022.

SELECT
  COUNT(ride_id) total_id,
  COUNT(DISTINCT ride_id) unique_id
FROM `practice-gda-377022.cyclistic.2022`;

-- Result:

total_id|unique_id|
--------+----------
5667643 |5667643

-- The total number of ride_id is 5,667,643, and they are all unique, so there's no need for deleting duplicate rows.

-- Mean, max, min time duration for 2022 whole year.
SELECT
  SUM(ended_at-started_at)/COUNT(*) avg_duration,
  MAX(ended_at-started_at) max_duration,
  MIN(ended_at-started_at) min_duration
FROM `practice-gda-377022.cyclistic.2022`;

-- Result:

avg_duration           |max_duration   |min_duration|
-----------------------+---------------+-------------
0-0 0 0:19:26.757015867|0-0 0 689:47:15| 0-0 0 0:0:0|



-- Explore statistics for each month

-- January 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-01-01' AND started_at < '2022-02-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
103770    |487         |0           |0-0 0 0:15:15.879840030 


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

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
115609    |181         |0           |0-0 0 0:14:14.419232066 


-- The total trip in February 2022 was 115,609, the most duration was 181 hours, the least duration was 0,
-- and the average duration was around 00:14:14.


-- March 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-03-01' AND started_at < '2022-04-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
284041    |572         |0           |0-0 0 0:18:29.839938600 


-- The total trip in March 2022 was 284,041, the most duration was 572 hours, the least duration was 0,
-- and the average duration was around 00:18:29.


-- April 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-04-01' AND started_at < '2022-05-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
371249    |352         |0           |0-0 0 0:17:38.121495276 


-- The total trip in April 2022 was 371,249, the most duration was 352 hours, the least duration was 0,
-- and the average duration was around 00:17:38.


-- May 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-05-01' AND started_at < '2022-06-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
634858    |604         |0           | 0-0 0 0:21:5.860449108 


-- The total trip in May 2022 was 634,858, the most duration was 604 hours, the least duration was 0,
-- and the average duration was around 00:21:6.


-- June 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-06-01' AND started_at < '2022-07-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
769193    |597         |0           |0-0 0 0:22:41.006738230 


-- The total trip in June 2022 was 769,193, the most duration was 597 hours, the least duration was 0,
-- and the average duration was around 00:22:41.


-- July 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-07-01' AND started_at < '2022-08-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
823475    |570         |0           |0-0 0 0:21:23.468867907 


-- The total trip in July 2022 was 823,475, the most duration was 570 hours, the least duration was 0,
-- and the average duration was around 00:21:23.


-- August 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-08-01' AND started_at < '2022-09-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
785925    |468         |0           |0-0 0 0:20:39.450077297 


-- The total trip in August 2022 was 785,925, the most duration was 468 hours, the least duration was 0,
-- and the average duration was around 00:20:39.


-- September 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-09-01' AND started_at < '2022-10-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
701336    |461         |0           |0-0 0 0:19:19.527952365 


-- The total trip in September 2022 was 701,336, the most duration was 461 hours, the least duration was 0,
-- and the average duration was around 00:19:20.


-- October 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-10-01' AND started_at < '2022-11-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
558684    |689         |0           |0-0 0 0:17:21.365995804


-- The total trip in October 2022 was 558,684, the most duration was 689 hours, the least duration was 0,
-- and the average duration was around 00:17:21.


-- November 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-11-01' AND started_at < '2022-12-01';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
337697    |326         |0           | 0-0 0 0:14:9.928323319


-- The total trip in November 2022 was 337,697, the most duration was 326 hours, the least duration was 0,
-- and the average duration was around 00:14:10.


-- December 2022

SELECT
  COUNT(*) total_trip,
  MAX(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) max_duration,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, HOUR)) min_duration,
  SUM(ended_at-started_at)/COUNT(*) avg_duration
FROM `practice-gda-377022.cyclistic.2022`
WHERE started_at >= '2022-12-01' AND started_at <= '2022-12-31';

-- Result:

total_trip|max_duration|min_duration|avg_duration          |
----------+------------+------------+-----------------------
176753    |319         |0           |0-0 0 0:13:25.287072920


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



-- Create a table for further analysis with weekday, and extract day, month, start hour, and minute duration.

SELECT 
  ride_id,
  DATE(started_at) AS day,
  FORMAT_DATE('%B', DATE(started_at)) AS month,
  FORMAT_DATE('%A', DATE(started_at)) AS weekday,
  FORMAT_TIME('%k', TIME(started_at)) AS start_hour,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS duration_minute
FROM `practice-gda-377022.cyclistic.2022`
ORDER BY day, ride_id;

-- Saved as '2022weekday'

