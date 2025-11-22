-----SQL RETAIL SALES ANALYSIS---PROJECT 1
create database SQL_PROJECT_P1;
USE SQL_PROJECT_P1;


DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(30),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
select * from retail_sales;

SELECT DATABASE();
SHOW TABLES;
SELECT table_name, table_rows
FROM information_schema.tables
WHERE table_schema = 'sql_project_p1';
SELECT * FROM retail_sales limit 10 ;

select * from retail_sales where 
transactions_id is null
or 
sale_date is null
or 
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

update retail_sales
set quantity = Null
where quantity = '0';

update retail_sales
set price_per_unit = null
where quantity = '0';

update retail_sales
set price_per_unit = null
where price_per_unit ='0';

update retail_sales
set cogs = null
where cogs = '0';

update retail_sales
set total_sale = Null
where total_sale = '0';

delete from retail_sales
where 
transactions_id is null
or 
sale_date is null
or 
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

select count(*) from retail_sales;
describe table retail_sales;
select count(*) as sales from retail_sales;

select count(distinct customer_id) as sales from retail_sales;

select distinct category from retail_sales;
select * from retail_sales;
select * from retail_sales
where sale_date= '2022-11-05';
Q2- RETREIVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND QUANTITY SOLD IS MORE THAN = 4 IN THE MONTH OF NOV
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  and quantity >=4;
  
  Q3-CALCULATE THE TOTAL SALES FOR EACH CATEGORY
  select category, 
  sum(total_sale) as sales,
  count(*) as orders
  from retail_sales
  group by category;
  
  Q4- FIND AVERAGE AGE OF CUSTOMER WHO PURCHASED ITEM FROM BEAUTY 
  select avg(age) from retail_sales
  where category = 'Beauty';
Q5- find all transactions wherev total sale is greater than 1000. 
select *
from retail_sales
where total_sale > 1000;

Q6- FIND TOTAL NU,BER OF TRANSACTIONS MADE BY EACH GENDER
select category, gender,
count(*) as total_trans
from retail_sales
group by category,
gender
order by category;

select * from retail_sales;
---Q7- calculate the average sale for each month , selling month in each year------
select 
EXTRACT(year from sale_date) as year,
EXTRACT(month from sale_date) as month,
avg(total_sale) as avg_Sale
from retail_sales
group by 1,2
order by 1,2;

Q8- find the top 5 customers based on highest sale
select customer_id,
sum(total_sale) as total_Sales
from retail_sales
group by 1
order by 2 desc
limit 5;

Q9-find the number of unique customer who purchased items from each category

select category, count(distinct customer_id) as CNT
from retail_sales
group by category;

Q10- SQL query to create each shift and number of orders (example morning <=12 , afternoon between 12 & 17 , evening >17)

WITH HOURLY_SALE
AS (
select *,
CASE
WHEN HOUR (SALE_TIME) < 12 THEN 'Morning' 
WHEN HOUR (SALE_TIME) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS SHIFT
FROM RETAIL_SALES
)
SELECT 
SHIFT,
COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT
