-- Analyze: The different usage for casual and member users.

-- 1. Calculate the total members and casual users.

SELECT
  member_casual,
  COUNT(ride_id) total_users
FROM `practice-gda-377022.cyclistic.2022`
GROUP BY member_casual;

-- Result:

member_casual|total_users|
-------------+------------
       member|    3345640| 
       casual|    2321977| 

  -- The total members are 3,345,640, and the total casual users are 2,321,977



--2. Observe the rideable_type preference of members and casual users.

SELECT
  c2.member_casual,
  rideable_type,
  COUNT(c2.ride_id) num_ride
FROM `practice-gda-377022.cyclistic.2022`AS c2
INNER JOIN `practice-gda-377022.cyclistic.2022weekday` AS w
  ON c2.ride_id = w.ride_id
GROUP BY c2.member_casual, rideable_type
ORDER BY num_ride DESC;

-- Result:

member_casual|rideable_type|num_ride|
-------------+-------------+---------
       member| classic_bike| 1709743|
       member|electric_bike| 1635897|
       casual|electric_bike| 1253060|
       casual| classic_bike|  891443|
       casual|  docked_bike|  177474|


-- I observe that members like classic bike (1,709,744) more than electric bike (1,635,908) and they've never used docked bike.
-- However, casual users like electric bike (1,253,071) more than classic bike (891,446) and docked bike (177,474).



--3. Observe the time preference of members and casual users.

--(1) Month

SELECT 
  c2.member_casual,
  month,
  COUNT(*) total_trips
FROM `practice-gda-377022.cyclistic.2022` AS c2
INNER JOIN `practice-gda-377022.cyclistic.2022weekday` AS w
  ON c2.ride_id = w.ride_id
GROUP BY
  month,
  c2.member_casual
ORDER BY total_trips DESC;

-- Result:

member_casual|        month|total_trips|
-------------+-------------+------------
       member|       August|     427000|
       member|         July|     417426|
       casual|         July|     406046|
       member|    September|     404636|
       member|         June|     400148|
       casual|         June|     369044|
       casual|       August|     358917|
       member|          May|     354443|
       member|      October|     349693|
       casual|    September|     296694|
       casual|          May|     280414|
       member|        April|     244832|
       member|     November|     236947|
       casual|      October|     208988|
       member|        March|     194160|
       member|     December|     136912|
       casual|        April|     126417|
       casual|     November|     100747|
       member|     February|      94193|
       casual|        March|      89880|
       member|      January|      85250|
       casual|     December|      44894|
       casual|     February|      21416|
       casual|      January|      18520|

-- Members did the most trips in August and the least in January.
-- Casual users did the most trips in July and the least in January.



-- Average duration for month
SELECT
  month,
  AVG(duration_minute) avg_duration,
FROM `practice-gda-377022.cyclistic.2022weekday`
GROUP BY month
ORDER BY avg_duration DESC;

-- Result:

month        |avg_duration      |
-------------+-------------------
June         |22.19401762626552 |
July         |20.90183915722978 |
May          |20.608780231169817|
August       |20.168149632      |
September    |18.83615699179931 |
March        |18.00799884523671 |
April        |17.146909486625034|
October      |16.866769050124773|
January      |14.773942372554721|
February     |13.752796062590317|
November     |13.676144591157046|
December     |13.0130028711     |



--(2) Weekday and hour
--Average duration for weekday
SELECT
  weekday,
  AVG(duration_minute) avg_duration,
FROM `practice-gda-377022.cyclistic.2022weekday`
GROUP BY weekday
ORDER BY avg_duration DESC;
-- Weekends have the longest average duration, around 24 minutes.

--Average duration for hour
SELECT
  start_hour,
  AVG(duration_minute) avg_duration,
FROM `practice-gda-377022.cyclistic.2022weekday`
GROUP BY start_hour
ORDER BY avg_duration DESC;
-- 1-3 am have the longest average duration, with 3 am 29.67, 2 am 29.61, and 1 am 27.67 minutes.

-- Analyze the preference of different user types
SELECT 
  c2.member_casual,
  weekday,
  start_hour,
  COUNT(*) total_trips
FROM `practice-gda-377022.cyclistic.2022` AS c2
INNER JOIN `practice-gda-377022.cyclistic.2022weekday` AS w
  ON c2.ride_id = w.ride_id
WHERE c2.member_casual = 'member'
GROUP BY 
  weekday,
  start_hour,
  member_casual
ORDER BY
  total_trips DESC;
-- I observe that members preferred to ride bikes at 5 pm on weekdays, specifically Monday - Thursday.
SELECT 
  c2.member_casual,
  weekday,
  start_hour,
  COUNT(*) total_trips
FROM `practice-gda-377022.cyclistic.2022` AS c2
INNER JOIN `practice-gda-377022.cyclistic.2022weekday` AS w
  ON c2.ride_id = w.ride_id
WHERE c2.member_casual = 'casual'
GROUP BY 
  weekday,
  start_hour,
  member_casual
ORDER BY
  total_trips DESC;
-- While casual members preferred to ride bikes on weekends and in the afternoon.

--4. Observe the duration difference between members and casual users.
SELECT
  member_casual,
  MAX(duration_minute) max_duration,
  MIN(duration_minute) min_duration,
  AVG(duration_minute) average_duration
FROM `practice-gda-377022.cyclistic.2022weekday`
GROUP BY member_casual;
-- Members' max duration minute was 1559.9, min was 0, and the average minute was 12.71.
-- Casual users' max duration minute was 41387.25, min was 0, and the average minute was 29.24.

--5. Explore popular areas for users.
SELECT
  member_casual,
  start_station_name,
  COUNT(start_station_name) num_ss
FROM `practice-gda-377022.cyclistic.2022`
WHERE start_station_name IS NOT NULL
GROUP BY
  start_station_name,
  member_casual
ORDER BY num_ss DESC;
-- Observe the popular areas for all users. Streeter Dr & Grand Ave was the most popular station for casual users;
-- Kingsbury St & Kinzie St was the most popular station for members.
