select * from pizza_sales;

select SUM(total_price) as Total_revenue from pizza_sales;

select SUM(total_price)/ count(distinct order_id) as avg_order from pizza_sales;

select SUM(quantity) as total_pizza_sold from pizza_sales;

select count(distinct order_id) as total_orders from pizza_sales;

select cast(cast(SUM(quantity)as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2))as decimal(10,2)) as avg_order from pizza_sales;

select datename(weekday,order_date) as day_name, count(distinct order_id) from pizza_sales
group by datename(weekday,order_date),datepart(weekday, order_date)
order by datepart(weekday, order_date);

select datename(month,order_date) as mon_name, count(distinct order_id) as orders from pizza_sales
group by datename(month,order_date), datepart(month,order_date)
order by count(distinct order_id) desc, datepart(month,order_date);

select pizza_category, sum(total_price) as sales, sum(total_price) *100 / (select sum(total_price) from pizza_sales) as percent_sales from pizza_sales
group by pizza_category;

--top 5 revenue

select top 5 pizza_name, sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue desc

select top 5 pizza_name, sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue asc

--which is the most sold large pizza 

with cte as (select pizza_name, SUM(quantity) as sales, pizza_size from pizza_sales
group by pizza_name, pizza_size
)
select top 1 * from cte
where pizza_size ='L'
order by sales desc