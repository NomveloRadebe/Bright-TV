

SELECT 
    CAST(A.RecordDate2 AS DATE) AS SeparateDate,
    date_format(A.RecordDate2, 'HH:mm:ss') AS start_time, 
    A.UserID0, 
    A.RecordDate2, 
    A.Channel2, 
    date_format(A.RecordDate2, 'EEEE') AS Day_Name, 
    date_format(A.RecordDate2, 'MMMM') AS Month_Name,
    from_utc_timestamp(A.RecordDate2, 'Africa/Johannesburg') AS RecordDate_SA,
    CASE 
        WHEN date_format(A.RecordDate2, 'EEEE') IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Classification, 
    CASE
        WHEN date_format(A.RecordDate2, 'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN '01.Morning'
        WHEN date_format(A.RecordDate2, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
        WHEN date_format(A.RecordDate2, 'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
        ELSE '04.Late'
    END AS time_buckets,
    date_format(A.`duration 2`, 'HH:mm:ss') AS DURATION,
    CASE
        WHEN date_format(A.`duration 2`, 'HH:mm:ss') BETWEEN '00:00:00' AND '00:30:59' THEN 'LOW_DURATION'
        WHEN date_format(A.`duration 2`, 'HH:mm:ss') BETWEEN '00:31:00' AND '02:59:59' THEN 'MEDIUM_DURATION'
        WHEN date_format(A.`duration 2`, 'HH:mm:ss') > '03:00:00' THEN 'HIGH_DURATION'
        ELSE 'VERY_HIGH_DURATION'
    END AS consumption_buckets,
    COUNT(A.UserID0) AS Number_of_Profiles, 
    COUNT(DISTINCT A.Channel2) AS Number_of_Channels,
    COUNT(A.Channel2) AS Total_Channel_Views,
    COUNT(B.UserID) AS Number_Of_Viewers,

   IFNULL(B.Gender, 'unknown') AS Gender,
    IFNULL(B.Province, 'unkown') AS Province,
    IFNULL(B.Race, 'unknown') AS Race,
    COALESCE(B.Age, 0) AS Generation,
    
    CASE
        WHEN B.Age BETWEEN 0 AND 12 THEN 'Child'
        WHEN B.Age BETWEEN 13 AND 19 THEN 'Teen'
        WHEN B.Age BETWEEN 20 AND 39 THEN 'Young_Adult'
        WHEN B.Age BETWEEN 40 AND 59 THEN 'Middle_Aged'
        ELSE 'Senior_60+'
    END AS Age_Basket
   
FROM `workspace`.`default`.`bright_tv_viewership` AS A
FULL OUTER JOIN workspace.default.bright_tv_user_profiles AS B
    ON A.UserID0 = B.UserID
GROUP BY 
    CAST(A.RecordDate2 AS DATE),
    date_format(A.RecordDate2, 'HH:mm:ss'),
    A.UserID0,
    A.RecordDate2,
    A.Channel2,
    date_format(A.RecordDate2, 'EEEE'),
    date_format(A.RecordDate2, 'MMMM'),
    from_utc_timestamp(A.RecordDate2, 'Africa/Johannesburg'),
    Province,
   
    CASE 
        WHEN date_format(A.RecordDate2, 'EEEE') IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END,
    CASE
        WHEN date_format(A.RecordDate2, 'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN '01.Morning'
        WHEN date_format(A.RecordDate2, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
        WHEN date_format(A.RecordDate2, 'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
        ELSE '04.Late'
    END,
    date_format(A.`duration 2`, 'HH:mm:ss'),
    CASE
        WHEN date_format(A.`duration 2`, 'HH:mm:ss') BETWEEN '00:00:00' AND '00:30:59' THEN 'LOW_DURATION'
        WHEN date_format(A.`duration 2`, 'HH:mm:ss') BETWEEN '00:31:00' AND '02:59:59' THEN 'MEDIUM_DURATION'
        WHEN date_format(A.`duration 2`, 'HH:mm:ss') > '03:00:00' THEN 'HIGH_DURATION'
        ELSE 'VERY_HIGH_DURATION'
    END,
    B.Age,
    B.Gender,
    B.Race,
    
    CASE
        WHEN B.Age BETWEEN 0 AND 12 THEN 'Child'
        WHEN B.Age BETWEEN 13 AND 19 THEN 'Teen'
        WHEN B.Age BETWEEN 20 AND 39 THEN 'Young_Adult'
        WHEN B.Age BETWEEN 40 AND 59 THEN 'Middle_Aged'
        ELSE 'Senior_60+'
    END;





        


   


    
 

