Create database Transport;
Use Transport;

#1. Retrieve all successful bookings:
Create View Successful_Bookings As
SELECT * FROM Bookings 
WHERE Booking_Status = 'Success';

select * from Successful_Bookings;

#2. Find the average ride distance for each vehicle type:
Create view Ride_Distance_For_Each_Vehicle_Type as
SELECT Vehicle_Type, AVG(Ride_Distance) as avg_distange FROM bookings group by Vehicle_type;

select * from Ride_Distance_For_Each_Vehicle_Type;

#3. Get the total number of cancelled rides by customers:
Create view Rides_cancelled_by_customers as
SELECT COUNT(*) FROM bookings 
WHERE Booking_Status = 'Canceled by Customer';

select * from Rides_cancelled_by_customers;

#4. List the top 5 customers who booked the highest number of rides:
Create view top_5_customers As
SELECT Customer_ID , count(Booking_ID) as Total_rides from bookings
group by Customer_ID
ORDER BY Total_rides DESC LIMIT 5;

select * from top_5_customers;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Create view personal_and_car_related_issues as
SELECT count(*) from bookings where Canceled_Rides_by_Driver = 'Personal & Car-related issues';

select * from personal_and_car_related_issues;

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Create view Min_Max_rating_for_Prime_Sedan as 
select MIN(Driver_Ratings) as Min_rating , MAX(Driver_Ratings) as Max_Rating from bookings 
WHERE Vehicle_Type = 'Prime Sedan';

select * from Min_Max_rating_for_Prime_Sedan;

#7. Retrieve all rides where payment was made using UPI:
Create view UPI_payments as
select * from bookings
WHERE Payment_Method = 'UPI';

select * from UPI_payments;

#8. Find the average customer rating per vehicle type:
create view avg_rating_per_vehicle as
select Vehicle_Type , AVG(Customer_Rating) as avg_customer_rating FROM bookings
group by Vehicle_Type
order by avg_customer_rating DESC;

select * from avg_rating_per_vehicle;


#9. Calculate the total booking value of rides completed successfully:
create view Total_successful_booking_values AS
select sum(Booking_Value) as Total_successful_booking_values from bookings 
where Booking_Status = 'Success';

select * from Total_successful_booking_values;


#10. List all incomplete rides along with the reason:
create view Incomplete_Rides As
select Booking_ID, Incomplete_Rides_Reason from bookings 
WHERE Incomplete_Rides = 'Yes';

select * from Incomplete_Rides;


#11 Write a query to find all bookings made on '2024-11-01'
select Booking_ID 
from bookings
WHERE Date = '2024-07-30 19:59:00';


#12 Distinct Values: List all unique vehicle types used in the system.
create view Unique_Vehicle_Type AS 
select DISTINCT Vehicle_Type
from bookings;

select * from Unique_Vehicle_Type;


#13 Grouping and Aggregation: Find the total booking value collected for each payment method.
CREATE view Booking_Value_Payment_Type AS
select Payment_Method, SUM(Booking_Value) as Total_Booking_Value
from bookings 
group by Payment_Method;

select * from Booking_Value_Payment_Type;


#14 Join Simulation (Self-Join): Identify customers who have canceled rides multiple times
create view Cust_cancelled_rides_Multiple as 
SELECT Customer_ID, SUM(Canceled_Rides_by_Customer) AS Total_Canceled_Rides
FROM bookings
GROUP BY Customer_ID
HAVING SUM(Canceled_Rides_by_Customer) > 1;

select* from Cust_cancelled_rides_Multiple;



#15 Conditional Filtering: Retrieve the list of rides where the ride distance was more than 10 km, and the driver rating was below 3.
select Booking_ID from bookings 
WHERE Ride_Distance > 10 AND Driver_Ratings < 5 ;


#16 Complex Aggregation and Filtering: Calculate the average Customer_Rating for each vehicle type, but only include rides with a distance greater than 5 km.
create view Avg_cust_rating as 
select Vehicle_Type, AVG(Customer_Rating) AS Average_Customer_Rating 
from bookings 
WHERE Ride_Distance > 5
group by Vehicle_Type;

select * from Avg_cust_rating;


#17 Time-Based Analysis: Find the hour during which the maximum number of bookings were made. Assume Time is in the format HH:MM:SS.
create view Time_Based_Analysis as
SELECT SUBSTR(Time, 1, 2) AS Booking_Hour, COUNT(*) AS Total_Bookings
FROM bookings
GROUP BY SUBSTR(Time, 1, 2)
ORDER BY Total_Bookings DESC
LIMIT 1;

select * from Time_Based_Analysis;

#18 Correlation Insights: Identify if there’s a trend between Booking_Value and Ride_Distance by finding the average booking value per kilometer for each ride.
create view Trend_value_distance as 
SELECT Booking_ID, (Booking_Value / Ride_Distance) AS Value_Per_Km
FROM bookings
WHERE Ride_Distance > 0;

select * from Trend_value_distance;



#19 Data Quality and Completeness: Find the percentage of rides where either Driver_Ratings or Customer_Rating is missing (NULL).
create view cust_driver_rating_ride_per as
SELECT (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM bookings) AS Percentage_Incomplete_Ratings
FROM bookings
WHERE Driver_Ratings IS NULL OR Customer_Rating IS NULL;

select * from cust_driver_rating_ride_per;
