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


-- I observe that members like classic bike (1,709,743) more than electric bike (1,635,897) and they've never used docked bike.
-- However, casual users like electric bike (1,253,060) more than classic bike (891,443) and docked bike (177,474).



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

member_casual|month        |total_trips|
-------------+-------------+------------
member       |August       |427000     |
member       |July         |417426     |
casual       |July         |406046     |
member       |September    |404636     |
member       |June         |400148     |
casual       |June         |369044     |
casual       |August       |358917     |
member       |May          |354443     |
member       |October      |349693     |
casual       |September    |296694     |
casual       |May          |280414     |
member       |April        |244832     |
member       |November     |236947     |
casual       |October      |208988     |
member       |March        |194160     |
member       |December     |136912     |
casual       |April        |126417     |
casual       |November     |100747     |
member       |February     |94193      |
casual       |March        |89880      |
member       |January      |85250      |
casual       |December     |44894      |
casual       |February     |21416      |
casual       |January      |18520      |

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

-- Result:

weekday        |avg_duration      |
---------------+-------------------
Sunday         |23.578776432515312|
Saturday       |23.189435700692972|
Friday         |18.517415516628652|
Monday         |18.035569291077525|
Thursday       |16.674995395592909|
Tuesday        |16.256463842362585|
Wednesday      |15.9621872110     |

-- Weekends have the longest average duration, around 23.58 minutes.



--Average duration for hour

SELECT
  start_hour,
  AVG(duration_minute) avg_duration,
FROM `practice-gda-377022.cyclistic.2022weekday`
GROUP BY start_hour
ORDER BY avg_duration DESC;

-- Result:

start_hour|avg_duration|
----------+-------------
3         |29.18636198 |
2         |29.12466751 |
1         |27.23924058 |
4         |24.27335306 |
23        |22.52502056 |
0         |22.39177206 |
14        |20.92658074 |
15        |20.68023763 |
11        |20.53922291 |
13        |20.40674046 |
12        |20.12165967 |
10        |19.99855332 |
19        |19.54170312 |
21        |19.37077884 |
20        |19.2380008  |
16        |19.06292251 |
22        |19.05048089 |
18        |18.65642071 |
17        |17.94228149 |
9         |15.84718489 |
5         |14.99105506 |
6         |13.70854567 |
8         |13.12464044 |
7         |13.07447184 |

-- 1-3 am have the longest average duration, with 3 am 29.18, 2 am 29.12, and 1 am 27.23 minutes.



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
  total_trips DESC
LIMIT 10;

-- Result:

member_casual|weekday      |start_hour|total_trips|
-------------+-------------+----------+-------------
member       |Wednesday    |17        |62673      |
member       |Tuesday      |17        |62132      |
member       |Thursday     |17        |59861      |
member       |Monday       |17        |56842      |
member       |Wednesday    |18        |48816      |
member       |Wednesday    |16        |48135      |
member       |Thursday     |18        |48053      |
member       |Tuesday      |16        |47901      |
member       |Tuesday      |18        |47070      |
member       |Thursday     |16        |47040      |
  
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
  total_trips DESC
LIMIT 10;

-- Result:
member_casual|weekday      |start_hour|total_trips|
-------------+-------------+----------+-------------
casual       |Saturday     |15        |40009      |
casual       |Saturday     |16        |38261      |
casual       |Saturday     |17        |38094      |
casual       |Saturday     |13        |36505      |
casual       |Saturday     |17        |35528      |
casual       |Saturday     |12        |34911      |
casual       |Sunday       |15        |34452      |
casual       |Thursday     |17        |33919      |
casual       |Sunday       |16        |33159      |
casual       |Sunday       |14        |32871      |
  
-- While casual riders preferred to ride bikes on weekends and in the afternoon.



--4. Observe the duration difference between members and casual users.

SELECT
  member_casual,
  MAX(duration_minute) max_duration,
  MIN(duration_minute) min_duration,
  AVG(duration_minute) average_duration
FROM `practice-gda-377022.cyclistic.2022weekday`
GROUP BY member_casual;

-- Result:

member_casual|max_duration|min_duration|average_duration  |
-------------+------------+------------+-------------------
member       |1559        |0           |12.224915203374429|
casual       |41387       |0           |28.656158012      |

-- Members' max duration minute was 1559.9, min was 0, and the average minute was 12.22.
-- Casual users' max duration minute was 41387.25, min was 0, and the average minute was 28.65.


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
ORDER BY num_ss DESC
LIMIT 10;

-- Result:

member_casual|start_station_name                |num_ss|
-------------+----------------------------------+-------------
casual       |Streeter Dr & Grand Ave           |58095 |
casual       |DuSable Lake Shore Dr & Monroe St |31862 |
casual       |Millennium Park                   |25530 |
casual       |Michigan Ave & Oak St             |25265 |
member       |Kingsbury St & Kinzie St          |24937 |
casual       |DuSable Lake Shore Dr & North Blvd|23657 |
member       |Clark St & Elm St                 |22040 |
member       |Wells St & Concord Ln             |21298 |
casual       |Shedd Aquarium                    |20265 |
member       |University Ave & 57th St          |19953 |

-- Observe the popular areas for all users. Streeter Dr & Grand Ave was the most popular station for casual users;
-- Kingsbury St & Kinzie St was the most popular station for members.
