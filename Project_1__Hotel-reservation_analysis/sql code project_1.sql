use `db` ;
CREATE TABLE db.hotel_reservation (
    Booking_ID VARCHAR(50) PRIMARY KEY,
    no_of_adults INT,
    no_of_children INT,
    no_of_weekend_nights INT,
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR(255),
    room_type_reserved VARCHAR(255),
    lead_time INT,
    arrival_date DATE,
    market_segment_type VARCHAR(255),
    avg_price_per_room DECIMAL(10, 2),
    booking_status VARCHAR(50)
);

select * from hotel ;


LOAD DATA INFILE 'C:\Users\HP\Desktop\OnlineInternship\mentorness\Project_1_Hotel_reservation_Analysis_using_SQL\Hotel_Reservation_Dataset.csv'
INTO TABLE hotel
FIELDS TERMINATED BY ',' -- adjust based on your CSV file delimiter
ENCLOSED BY '"' -- adjust based on your CSV file enclosure
LINES TERMINATED BY '\n' -- adjust based on your CSV file line terminator
IGNORE 1 ROWS; -- if your CSV file contains a header row


-- 1. What is the total number of reservations in the dataset?
SELECT count(DISTINCT `Booking_ID`) from hotel ;

-- 2. Which meal plan is the most popular among guests?
SELECT type_of_meal_plan, COUNT(*) AS plan_count
FROM hotel
GROUP BY type_of_meal_plan
ORDER BY plan_count DESC
LIMIT 1;


-- 3. What is the average price per room for reservations involving children?
SELECT avg_price_per_room ,  room_type_reserved
from hotel
where  no_of_children > 0 ;


-- 4. How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT count(*)
from hotel 
WHERE YEAR(STR_TO_DATE(arrival_date, '%Y-%m-%d')) = 2017;


-- 5. What is the most commonly booked room type?
SELECT  room_type_reserved , count(*) as room_type_count
from hotel
group by  room_type_reserved
order by   room_type_count DESC
LIMIT 1 ;


-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
SELECT count(*) as weekend_nights
from hotel
where no_of_weekend_nights > 0 ;


-- 7. What is the highest and lowest lead time for reservations?
SELECT min(lead_time) as min_lead_time , max(lead_time) as max_lead_time
from hotel ;


-- 8. What is the most common market segment type for reservations?
SELECT market_segment_type , count(*) as market_segment_type_count
from hotel group by market_segment_type
order by market_segment_type_count DESC LIMIT 1 ;
 
 
-- 9. How many reservations have a booking status of "Confirmed"?
SELECT  booking_status , count(*) as  booking_status_confirmed
from hotel where  booking_status LIKE "Not_Canceled"
group by  booking_status
order by  booking_status_confirmed DESC LIMIT 1 ;


-- 10. What is the total number of adults and children across all reservations?
SELECT sum(no_of_adults) + sum(no_of_children) as total_number_of_adults_children
from hotel ;


-- 11. What is the average number of weekend nights for reservations involving children?
SELECT round(avg( no_of_weekend_nights)) as  'average number of weekend nights for reservations involving children'
from hotel where no_of_children > 0 ;

-- 12. How many reservations were made in each month of the year?
SELECT month(STR_TO_DATE(arrival_date, '%Y-%m-%d')) as month , count(*) as reservations_count
from hotel group by month order by month ;


-- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
SELECT room_type_reserved , round(avg(no_of_weekend_nights + no_of_week_nights)) as "average number of nights"
from hotel group by room_type_reserved ;


-- 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
SELECT  room_type_reserved , count(*) as room_type_count , avg_price_per_room
from hotel where no_of_children > 0 
group by  room_type_reserved , avg_price_per_room
order by   room_type_count DESC
LIMIT 1 ;

-- 15. Find the market segment type that generates the highest average price per room
 SELECT market_segment_type , avg_price_per_room
 from hotel where avg_price_per_room >= (SELECT max(avg_price_per_room) from hotel)













