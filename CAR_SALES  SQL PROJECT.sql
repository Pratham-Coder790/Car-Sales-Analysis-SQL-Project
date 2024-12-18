CREATE DATABASE CAR_SALES;
USE CAR_SALES;

CREATE TABLE data_01(
id int auto_increment primary key,
car_model varchar(100),
car_make varchar(100),
year int,
price decimal(10, 2));

select * from data_01;

CREATE TABLE data_02(
id int auto_increment primary key,
customer_name varchar(100),
purchase_date DATE,
car_id int,
foreign key (car_id) references data_01(id));
select * from data_02;

INSERT INTO data_01(id,car_model,car_make,year,price)
values(1,'K5','Kia',2022,23000.00),
(2,'F-150','Ford',2022,40000.00),
(3,'Model 3','Tesla',2022,45000.00),
(4,'Model Y','Tesla',2021,48000.00),
(5,'Sonata','Hyundai',2021,24000.00),
(6,'Seltos','Kia',2021,26000.00),
(7,'Toyato','Innova Crysta',2024,30000.00),
(8,'Maruti Suzuki','Swift Dzire',2021,35000.00),
(9,'CX-5','Mazda',2021,28000.00),
(10,'Sentra','Nissan',2021,19000.00),
(11,'Accord','Honda',2020,24000.00),
(12,'Altima','Nissan',2020,23000.00),
(13,'Civic','Honda',2022,22000.00),
(14,'Mazda3,','Mazda',2022,21000.00),
(15,'A4','Audi',2023,45000.00),
(16,'X5','BMW',2022,60000.00),
(17,'Q5','Audi',2021,48000.00),
(18,'CR-V','Honda',2022,32000.00),
(19,'F-150','Ford',2021,55000.00),
(20,'3 Series','BMW',2023,52000.00);

select * from data_01;

INSERT INTO data_02(Customer_name,Purchase_date,car_id)
values('Saurabh Bansosde','2023-03-15',1),
('Pratik Kulkarni','2023-03-18',2),
('Ketan Rale','2023-03-20',3),
('Nitin Patil','2023-03-22',4),
('Aniket Jadhav','2023-04-01',5),
('Prathamesh Patil','2023-04-05',6),
('Arjun Patil','2023-04-10',7),
('Muzzamil Sayyed','2023-04-15',8),
('Sushant Pawar','2023-04-20',9),
('Omkar Kardile','2023-04-25',10),
('Ayush Padhare','2023-05-01',11),
('Ashish Halijol','2023-05-05',12),
('Ajit Kadam','2023-05-10',13),
('Asif Pathan','2023-05-15',14),
('Raj Nale','2023-05-20',15),
('Om Bhosale','2023-05-25',16),
('Prem Salunkhe','2023-06-02',17),
('Nikhil Pol','2023-06-05',18),
('Sahil Jadhav','2023-06-10',19),
('Purvesh Patil','2023-06-15',20);

select * from data_02;

-- LIKE OPERATOR 
-- Q.1) Customers Whose Name Contains 'S' as the Second Letter.
SELECT Customer_name, Purchase_date, car_id
FROM data_02
WHERE Customer_name LIKE '_S%';

--  Q.2) Customers with 'Patil' in Their Name.
SELECT customer_name,purchase_date,car_id
from data_02
where customer_name like '%Patil%';

-- Q.3) Which 10 cars were manufactured the earliest?
select car_model,car_make,year
from data_01
order by year asc
limit 10;

-- GROUP BY
--  Q.4) How many cars are there for each car make in the dataset?
select car_make,count(*) as total_cars
from data_01
group by car_make;

-- ORDER BY 
-- Q.5) List all cars ordered by cost in ascending order.
select * 
from data_01
order by cost asc;

-- SUB QUERY 
-- Q.6) What is the model of the car with the highest cost?
select car_model 
from data_01
where cost = (select max(cost) from data_01);

-- Having Query
-- Q.7) Find the car manufacturers (makes) that have more than 2 cars listed in the dataset.
select car_make,count(*) as total_number
from data_01
group by car_make
having count(*) > 2;

-- STRING FUNCTION 
-- Q.8) Find the length of each customer name.
select customer_name,length(customer_name) as name_length
from data_02;

-- MATH FUNCTION 
-- Q.9) Round the price of all cars to the nearest whole number.
select car_model,cost,round(cost) as rounded_cost
from data_01;

-- Aggragete function 
-- Q.10) Find the Average, Maximum, and Minimum Prices for Cars in 2022:
SELECT AVG(cost) AS avg_price, MAX(cost) AS max_price, MIN(cost) AS min_price
FROM data_01
WHERE year = 2022;


-- COMPARISON FUNCTION 
-- Q.11) Find Cars Priced Between $30,000 and $50,000
select car_model,car_make,year,cost
from data_01
where cost between 30000 and 50000; 

-- DATE FUNCTION
-- Q.12) Extract the car model, car make, year, and cost for all cars manufactured after the year 2020.
select car_model,car_make,year,cost
from data_01
where year > 2022;

-- RANGE OPERTORS
-- Q.13) Find car id Within a Certain Range.
select customer_name,purchase_date,car_id
from data_02
where car_id between 5 and 10;

-- Q.14) What is the total cost for each year after 2020?
SELECT year, SUM(cost) AS total_cost
FROM data_01
GROUP BY year
having year > 2020;

-- Arithmetic Operators
-- Q.15) What is the cost of each car if a 20% tax is applied?
select car_model,car_make,year,cost,(cost * 2.10) as cost_with_tax
from data_01;


-- JOINS--
-- 1) INNER JOIN
-- Q.16) Which customer purchased the most expensive car, and what are the details of the car (model, make, and cost)?

select
data_02.Customer_name,
data_02.purchase_date,
data_01.car_model,
data_01.car_make,
data_01.cost
from data_02 
inner join data_01
on 
data_02.car_id = data_01.id
where data_01.cost > 50000;


 
-- 2) LEFT JOIN
-- Q.17) What are the details of all customers who purchased cars costing more than $20,000?
select 
data_02.customer_name,
data_02.purchase_date,
data_01.car_model,
data_01.car_make,
data_01.year,
data_01.cost
from data_02
left join data_01
on 
data_02.car_id = data_01.id
where data_01.cost > 20000;

-- 3)RIGHT JOIN
-- Q.18) What are the details of all cars manufactured from 2020 onwards, and which customers (if any) have purchased them?
select 
data_02.customer_name,
data_02.purchase_date,
data_01.car_model,
data_01.car_make,
data_01.year,
data_01.cost
from data_02
right join data_01
on 
data_02.car_id = data_01.id
where data_01.year >= 2020;


-- FULL OUTER JOIN 
-- Q.19) Retrieve All Cars and Customers Where Cars Are cost Above $30,000
select 
data_02.customer_name,
data_02.purchase_date,
data_01.car_model,
data_01.car_make,
data_01.year,
data_01.cost
from data_02
left join data_01
on 
data_02.car_id = data_01.id
where data_01.cost > 30000
union 
select 
data_02.customer_name,
data_02.purchase_date,
data_01.car_model,
data_01.car_make,
data_01.year,
data_01.cost
from data_02
right join data_01
on 
data_02.car_id = data_01.id 
where data_01.cost > 40000;
 

-- SELF JOIN
-- Q.20) List all cars where the model name is alphabetically before another model from the same manufacturer.
SELECT a.car_model AS model_1, a.car_make, b.car_model AS model_2
FROM data_01 a
JOIN data_01 b
ON a.car_make = b.car_make
AND a.car_model < b.car_model;







