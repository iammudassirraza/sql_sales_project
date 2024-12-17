Create database Shoping;

Use Shoping;

Create table total_sales
(
	transactions_id	INT Primary key,
	sale_date	DATE,
    sale_time	TIME,
    customer_id	INT,
	gender	VARCHAR(15),
    age	INT,
    category VARCHAR(25),
    quantiy	INT,
    price_per_unit	FLOAT,
    cogs	FLOAT,
    total_sale FLOAT
); 

Select * from total_sales
limit 10;

select count(*) from total_sales;

-- COUNTING EACH AGE PEOPLE --

Select age, count(age)
from total_sales
group by age;

-- COUNTING CATEGORY --

Select category, count(category)
from total_sales
group by category;

-- WE NEED TO CHECK THE NULL VALUES EXIST IN OUR TABLE--

SELECT * from total_sales 
where transactions_id is null or 
sale_date is null or 
sale_time	is null or
customer_id	is null or
gender	is null or
age	is null or
category	is null or
quantiy	is null or
price_per_unit	is null or
cogs is null or
total_sale is null;

-- DATA ANALYSIS QUESTIONS -- 

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05  ---

SELECT * from total_sales
where sale_date = '2022-11-05';


-- Q.2 Find all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022-- 

-- CORRECTING THE SPEALING OF QUANTIY to QUANTITY -- 

Alter table total_sales
change quantiy  quantity INT;

select * from total_sales
where category = 'clothing'
AND 
quantity > 3
AND 
sale_date between '2022-11-01' AND '2022-11-30';

-- Q.3. Write a SQL query to calculate the total sales (total_sale) for each category-- 

-- FIRST WE NEED TO CHECK THAT HOW MANY CATEGORIES ARE THERE --- 

Select category, count(category), SUM(total_sale)
from total_sales
group by category
having sum(total_sale);

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category-- 

SELECT AVG(age) AS average_age, category
FROM total_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.--

select * from total_sales 
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category-- 

SELECT category, gender, COUNT(transactions_id) AS total_transactions
FROM total_sales
group by category, gender;

-- Q.7 Calculate the average sale for each month.r--

-- average sale month--

select
  month(sale_date) as month,
  year(sale_date) as year,
  sum(total_sale),
  avg(total_sale) as avg_month
from total_sales
group by month(sale_date), year(sale_date)
order by avg_month desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales-- 

select customer_id,
sum(total_sale) as sale
from total_sales
group by customer_id
order by sale desc
limit 5;

-- Q.9 write a SQL query to find the number of unique customers who purchased items from each category--

select 
category,
count(DISTINCT customer_id) AS unique_id 
from total_sales
group by category;

-- Q.10. Write a SQL query to create each shift and number of orders (E.g Morning <=12, Afternoon Between 12 & 17, Evening >17)--

SELECT 
    CASE 
        WHEN HOUR(sale_time) <= 12 THEN 'Morning'
        WHEN HOUR(sale_time) > 12 AND HOUR(sale_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(customer_id) AS number_of_orders
FROM total_sales
GROUP BY shift;

































