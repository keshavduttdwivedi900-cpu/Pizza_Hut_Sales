#Basic :
# 1.Retrieve the total number of orders placed.
select * from orders;
select count(*) as total_orders from orders;
-- select sum(order_id) from orders;

-- 2.Calculate the total revenue generated from pizza sales.
select * from order_details;
select * from pizzas;

-- select o.quantity,p.price
-- from order_details o
-- join pizzas p on p.pizza_id = o.pizza_id


select round(sum(o.quantity * p.price),2) as total_sales
from order_details o
join pizzas p on p.pizza_id = o.pizza_id

-- 3.Identity the highest-priced pizza
select * from pizzas
select * from pizza_types



select p.price,pt.name
from pizzas p
join pizza_types pt  on  pt.pizza_type_id = p.pizza_type_id
order by price desc
limit 1

-- 4.Identify the most common pizza size ordered.
select * from pizzas
select * from order_details


select p.size,count(o.quantity)
from pizzas p 
join order_details o on p.pizza_id = o.pizza_id
group by p.size
order by count(o.quantity) desc
limit 1

-- or

select p.size,o.quantity
from pizzas p 
join order_details o on p.pizza_id = o.pizza_id
order by o.quantity desc
limit 1

-- 5.List the top 5 most ordered pizza types along with their quantities.
select * from order_details;
select * from  pizza_types;
select * from pizzas;

select pt.name,sum(o.quantity)
from order_details o
join pizzas p on o.pizza_id = p.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.name
order by sum(o.quantity) desc
limit 5





































